{pkgs, ...}: {
  imports = [
    ../../gui
    ../../shells
    ../../tui
  ];

  home.packages = with pkgs; [
    # freecad
    freetype # A font rendering engine
    linuxKernel.packages.linux_zen.xpadneo
    lutris
    # minecraft
    prusa-slicer
    steam
    wineWowPackages.waylandFull
  ];
}
