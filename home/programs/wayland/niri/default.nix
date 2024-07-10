{inputs, pkgs, ...}:
{
  imports = [
    inputs.niri.homeModules.niri
    # ./binds.nix
  ];

  programs.niri = {
    enable  = true;

    # https://github.com/sodiboo/niri-flake/blob/main/docs.md
    settings = {
      environment = {
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = null;
      };

      spawn-at-startup = [      
        command = {
          # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "${pkgs.avizo}/bin/avizo-service"
          # "${deadd-notification-center}"
          "${pkgs.hypridle}/bin/hypridle"
          "${pkgs.hyprpaper}/bin/hyprpaper"
          "${pkgs.smile}/bin/smile --start-hidden" # Emoji picker for linux
          "${pkgs.udiskie}/bin/udiskie"
          "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
          "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
          # "[workspace special:magic silent] wezterm start --class=floating-mode"
        };
      ];
    };
  };
}
