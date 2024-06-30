{pkgs, ...}: {
  imports = [
    # ./deadd-notification-center.nix # A haskell-written notification center
    ./hyprland
    ./ironbar.nix # Customizable gtk-layer-shell wlroots/sway bar written in Rust
  ];

  home.packages = with pkgs; [
    oculante # A minimalistic crossplatform image viewer written in Rust
    # smile # An emoji picker for linux, with custom tags support and localization
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];
}
