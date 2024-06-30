{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    deadnix
    statix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
