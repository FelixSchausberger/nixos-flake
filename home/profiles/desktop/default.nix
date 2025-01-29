{pkgs, ...}: {
  imports = [
    ../../gui
    ../../gui/freecad.nix # General purpose Open Source 3D CAD/MCAD/CAx/CAE/PLM modeler
    ../../gui/steam.nix # A digital distribution platform
    ../../gui/prusaslicer.nix # G-code generator for 3D printer
    ../../shells
    ../../tui
  ];

  home.packages = with pkgs; [
    # freetype # A font rendering engine
    linuxKernel.packages.linux_zen.xpadneo # Advanced Linux driver for Xbox One wireless controllers
    lutris # Open Source gaming platform for GNU/Linux
    # minecraft
    wineWowPackages.waylandFull # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
  ];
}
