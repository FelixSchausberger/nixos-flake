{
  inputs,
  # defaultTerminal,
  pkgs,
  ...
}: let
  # Helper function to create command objects for spawn-at-startup
  # makeCommand = command: {
  #   command = [command];
  # };
  browser = "${pkgs.firefox}/bin/firefox";
  editor = "${pkgs.helix}/bin/hx";
  # terminal = "${pkgs.${defaultTerminal}}/bin/${defaultTerminal}";
  terminal = "${pkgs.cosmic-term}/bin/cosmic-term";
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./binds.nix
    ./rules.nix
  ];

  programs.bash = {
    enable = true;

    # Auto-start hyprland when logging into TTY1
    bashrcExtra = ''
      # Check if on TTY1 and start cosmic-session if necessary
      if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        pidof mylock > /dev/null || exec cosmic-session Hyprland
      fi
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        "TERMINAL,${terminal}"
        "BROWSER,${browser}"
        "EDITOR,${editor}"
        "SUDO_EDITOR,${editor}"
        "VISUAL,${editor}"
      ];

      monitor = "HDMI-A-1,1920x1080@60,0x0,1"; # Desktop

      decoration = {
        shadow = {
          enabled = true;
          color = "rgba(00000055)"; # 99
          ignore_window = true;
          offset = "0 15"; # 0 5
          range = 100;
          render_power = 2;
          scale = 0.97;
        };

        rounding = 10;

        blur = {
          enabled = true;
          ignore_opacity = true;
        };

        layerrule = [
          "blur,gtk-layer-shell"
          "blur,notifications"
        ];

        # windowrule = [
        #   "opacity 0.9 0.8, ^(cosmic-term)$"
        #   "float, ^(floating-mode)$"
        #   # "float, ^(pavucontrol)$"
        #   # "float, ^(it.mijorus.smile)$"
        #   "float, ^(Steam)$"
        # ];
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";
      "$terminal" = "${terminal}";
      "$fileManager" = "${pkgs.cosmic-files}/bin/cosmic-files";

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${pkgs.cosmic-ext-alternative-startup}/bin/cosmic-ext-alternative-startup"
        "${pkgs.cosmic-panel}/bin/cosmic-panel"
        # "${pkgs.cosmic-notifications-daemon}/bin/cosmic-notifications-daemon"
        "${pkgs.cosmic-settings-daemon}/bin/cosmic-settings-daemon"
        "${pkgs.gammastep}/bin/gammastep"

        # "${pkgs.hypridle}/bin/hypridle"
        # "${pkgs.udiskie}/bin/udiskie"
        # "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
        # "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"

        "[workspace special:planify silent] ${pkgs.planify}/bin/planify start --class=floating-mode"
        "[workspace special:spotify silent] ${pkgs.spotify}/bin/spotify start --class=floating-mode"
        "[workspace special:terminal silent] ${terminal} start --class=floating-mode"
      ];

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        # Enable variable refresh rate (effective depending on hardware)
        vrr = 1;
      };
    };

    # plugins = [
    #   inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    #   inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    # ];
  };
}
