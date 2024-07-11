{
  inputs,
  defaultTerminal,
  pkgs,
  ...
}: let
  browser = "${pkgs.firefox}/bin/firefox";
  # deadd-notification-center = "${pkgs.deadd-notification-center}/bin/deadd-notification-center";
  editor = "${pkgs.helix}/bin/hx";
  terminal = "${pkgs.${defaultTerminal}}/bin/${defaultTerminal}";
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        "QT_QPA_PLATFORM,wayland"

        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        "MOZ_ENABLE_WAYLAND,1"
        "MOZ_WEBRENDER,1"
        "MOZ_ACCELERATED,1"

        "TERMINAL,${terminal}"
        "BROWSER,${browser}"
        "EDITOR,${editor}"
        "SUDO_EDITOR,${editor}"
        "VISUAL,${editor}"
      ];

      monitor = "HDMI-A-1,1920x1080@60,0x0,1"; # Desktop

      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
        rounding = 10;

        blur.enabled = true;

        layerrule = [
          "blur,gtk-layer-shell"
          "blur,notifications"
        ];

        windowrule = [
          "float, ^(floating-mode)$"
          "float, ^(pavucontrol)$"
          "float, ^(it.mijorus.smile)$"
          "float, ^(Steam)$"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mod" = "SUPER";
      "$terminal" = "${terminal}";
      "$fileManager" = "${pkgs.spacedrive}/bin/spacedrive";

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "${pkgs.avizo}/bin/avizo-service"
        # "${deadd-notification-center}"
        "${pkgs.hypridle}/bin/hypridle"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.smile}/bin/smile --start-hidden" # Emoji picker for linux
        "${pkgs.udiskie}/bin/udiskie"
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"

        "[workspace special:magic silent] wezterm start --class=floating-mode"
      ];

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };

    # plugins = [
    #   inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    #   inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    # ];
  };
}
