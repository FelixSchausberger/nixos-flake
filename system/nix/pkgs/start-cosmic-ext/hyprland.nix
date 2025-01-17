{
  pkgs,
  specialArgs,
  ...
}: {
  services.displayManager.sessionPackages = [
    ((
        pkgs.writeTextFile {
          name = "cosmic-on-hyprland";
          destination = "/share/wayland-sessions/COSMIC-on-hyprland.desktop";
          text = ''
            [Desktop Entry]
            Name=COSMIC-on-hyprland
            Comment=This session logs you into the COSMIC desktop on Hyprland
            Type=Application
            DesktopNames=Hyprland
            Exec=${pkgs.writeShellApplication {
              name = "start-cosmic-ext-hyprland";
              runtimeInputs = [
                pkgs.systemd
                pkgs.dbus
                specialArgs.inputs.nixos-cosmic.packages.x86_64-linux.cosmic-session
                pkgs.bash
                pkgs.coreutils
              ];
              text = ''
                set -e

                # Cleanup any existing DBus server files
                rm -f /tmp/cosmic-notification-* || true
                rm -f /run/user/$UID/cosmic-notification-* || true

                if command -v systemctl >/dev/null; then
                    # Reset failed units
                    for unit in $(systemctl --user --no-legend --state=failed --plain list-units | cut -f1 -d' '); do
                        partof="$(systemctl --user show -p PartOf --value "$unit")"
                        for target in cosmic-session.target graphical-session.target; do
                            if [ "$partof" = "$target" ]; then
                                systemctl --user reset-failed "$unit"
                                break
                            fi
                        done
                    done

                    # Stop any running cosmic services
                    systemctl --user stop cosmic-notifications.service || true
                    systemctl --user stop cosmic-panel.service || true
                fi

                # Shell environment handling
                if [ -n "''${SHELL:-}" ]; then
                    if [ "''${1:-}" != "--in-login-shell" ]; then
                        exec bash -c "exec -l ${"'"}''${SHELL}' -c ${"'"}''${0} --in-login-shell'"
                    fi
                fi

                # Environment setup
                export DAEMON_NOTIFICATIONS_FD=18
                export PANEL_NOTIFICATIONS_FD=18
                export XDG_CURRENT_DESKTOP="''${XDG_CURRENT_DESKTOP:=Hyprland}"
                export XDG_SESSION_DESKTOP="''${XDG_SESSION_DESKTOP:=Hyprland}"
                export XDG_SESSION_TYPE="''${XDG_SESSION_TYPE:=wayland}"
                export XCURSOR_THEME="''${XCURSOR_THEME:=Cosmic}"
                export _JAVA_AWT_WM_NONREPARENTING=1
                export GDK_BACKEND=wayland,x11
                export MOZ_ENABLE_WAYLAND=1
                export MOZ_WEBRENDER=1
                export MOZ_ACCELERATED=1
                export QT_QPA_PLATFORM="wayland;xcb"
                export QT_AUTO_SCREEN_SCALE_FACTOR=1
                export QT_ENABLE_HIGHDPI_SCALING=1
                export HYPRLAND_LOG_WLR=1

                if command -v systemctl >/dev/null; then
                    systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP PANEL_NOTIFICATIONS_FD DAEMON_NOTIFICATIONS_FD
                fi

                # Ensure DBus is running
                if [[ -z "''${DBUS_SESSION_BUS_ADDRESS}" ]]; then
                    eval $(dbus-launch --sh-syntax)
                    export DBUS_SESSION_BUS_ADDRESS
                    exec cosmic-session Hyprland
                else
                    exec cosmic-session Hyprland
                fi
              '';
            }}/bin/start-cosmic-ext-hyprland
          '';
        }
      )
      .overrideAttrs
      {
        passthru.providedSessions = ["COSMIC-on-hyprland"];
      })
  ];
}
