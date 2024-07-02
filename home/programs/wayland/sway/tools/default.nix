{pkgs, ...}: {
  imports = [
    # ./dunst.nix
    ./swayidle.nix
    ./swayosd.nix
    ./waybar.nix
  ];
}
