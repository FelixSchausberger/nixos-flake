{pkgs, ...}: {
  programs.nh = {
    # Yet another nix cli helper
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/per/etc/nixos";
  };

  fonts.packages = with pkgs; [
    symbola # Basic Latin, Greek, Cyrillic and many Symbol blocks of Unicode: Used for nh
  ];
}
