{
  imports = [
    # ./dunst.nix # A notification daemon
    ./gammastep.nix # Screen color temperature manager
    ./hypridle.nix # Hyprland's idle daemon
    ./hyprpaper.nix # A blazing fast wayland wallpaper utility
    ./wayland-pipewire-idle-inhibit.nix # Suspends automatic idling of Wayland
    ./wlsunset.nix # Day/night gamma adjustments for Wayland
  ];
}
