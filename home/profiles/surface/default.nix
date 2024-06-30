{pkgs, ...}: {
  imports = [
    ../../programs
    ../../services
    ../../terminals
  ];

  home.packages = with pkgs; [
    tlp
  ];

  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "de";
    };
  };
}
