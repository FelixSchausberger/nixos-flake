{pkgs, ...}: {
  imports = [
    ../../gui
    ../../shells
    ../../tui
    ../../wm
  ];

  home.packages = with pkgs; [
    tlp
  ];
}
