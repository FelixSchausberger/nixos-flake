{pkgs, ...}: {
  imports = [
    ./qt.nix # A cross-platform application framework for C++
  ];

  environment.systemPackages = with pkgs; [
    dconf # Make HM-managed GTK stuff work
  ];
}
