{pkgs, ...}: 
let
  # Define the variable here
  windowManager = "Hyprland"; # or "niri-session"
  # windowManager = "sway";
{
  imports = [
    # ./deadd-notification-center.nix # A haskell-written notification center
    ./hyprland # A dynamic tiling Wayland compositor that doesn't sacrifice on its looks
    ./ironbar.nix # Customizable gtk-layer-shell wlroots/sway bar written in Rust
    ./niri # A scrollable-tiling Wayland compositor
    ./sway # An i3-compatible tiling Wayland compositor
  ];

  home.packages = with pkgs; [
    oculante # A minimalistic crossplatform image viewer written in Rust
    # smile # An emoji picker for linux, with custom tags support and localization
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];

  # Export the variable so it can be used in other files
  _module.args.windowManager = windowManager;
}
