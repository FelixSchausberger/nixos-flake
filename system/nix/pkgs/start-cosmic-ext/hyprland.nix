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
                pkgs.fish
              ];
              text = ''
                                set -e

                                # Clean up any existing DBus services
                                busctl --user list | grep cosmic | while read -r service rest; do
                                    busctl --user call org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus ReleaseName "s" "$service" || true
                                done

                                # Kill any existing cosmic processes
                                pkill -f "cosmic-" || true
                                sleep 1

                                # Ensure config directories exist
                #                 mkdir -p "$HOME/.config/cosmic/com.system76.CosmicSettings"
                #                 mkdir -p "$HOME/.config/cosmic/cosmic-panel"
                #                 mkdir -p "$HOME/.config/cosmic/cosmic-applet-tiling"

                #                 # Create basic tiling applet config
                #                 if [ ! -f "$HOME/.config/cosmic/cosmic-applet-tiling/config.kdl" ]; then
                #                     cat > "$HOME/.config/cosmic/cosmic-applet-tiling/config.kdl" << EOF
                # tiling = true
                # auto_tile = true
                # window_padding = 4
                # EOF
                #                 fi

                #                 # Create basic panel config if it doesn't exist
                #                 if [ ! -f "$HOME/.config/cosmic/cosmic-panel/config.kdl" ]; then
                #                     cat > "$HOME/.config/cosmic/cosmic-panel/config.kdl" << EOF
                # use_notifications = false
                # size_wings = 42
                # size_center = 42
                # EOF
                #                 fi

                                # Environment setup
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
                                    systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
                                fi

                                # Ensure DBus is running with clean session
                                if [[ -z "''${DBUS_SESSION_BUS_ADDRESS}" ]]; then
                                    dbus-daemon --session --address=unix:path=/run/user/$UID/bus
                                fi

                                sleep 2  # Give Hyprland time to initialize

                                # Let cosmic-session handle its own file descriptors
                                exec cosmic-session Hyprland
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
