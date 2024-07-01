{pkgs, ...}: 
let
  # Define the variable here
  windowManager = "Hyprland"; # or "niri-session"
{
  imports = [
    # ./deadd-notification-center.nix # A haskell-written notification center
    ./hyprland
    ./ironbar.nix # Customizable gtk-layer-shell wlroots/sway bar written in Rust
    ./niri
  ];

  home.packages = with pkgs; [
    oculante # A minimalistic crossplatform image viewer written in Rust
    # smile # An emoji picker for linux, with custom tags support and localization
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];

  # Export the variable so it can be used in other files
  _module.args.windowManager = windowManager;
}
