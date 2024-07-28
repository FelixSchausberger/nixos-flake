{pkgs, ...}: {
  imports = [
    ../../programs
    ../../terminals
  ];

  home.packages = with pkgs; [
    tlp
  ];
}
