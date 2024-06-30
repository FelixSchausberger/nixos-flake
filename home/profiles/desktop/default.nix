{pkgs, ...}: {
  imports = [
    ../../programs
    ../../services
    ../../terminals
  ];

  home.packages = with pkgs; [
    freecad
    freetype # A font rendering engine
    linuxKernel.packages.linux_zen.xpadneo
    lutris
    # minecraft
    prusa-slicer
    steam
    wineWowPackages.waylandFull
  ];

  # hardware = {
  #   xpadneo.enable = true;
  # };

  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "eu";
    kb_options = "caps:swapescape"; # Swap Caps-Lock and Escape
  };
}
