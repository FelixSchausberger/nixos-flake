{pkgs, ...}: {
  imports = [
    ../../gui
    ../../shells
    ../../tui
    ../../gui/steam.nix
  ];

  home.packages = with pkgs; [
    # freecad
    freetype # A font rendering engine
    linuxKernel.packages.linux_zen.xpadneo
    lutris
    # minecraft
    prusa-slicer
    wineWowPackages.waylandFull
  ];
}
