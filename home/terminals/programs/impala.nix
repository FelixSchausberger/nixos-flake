{pkgs, ...}: {
  home.packages = with pkgs; [
    impala # TUI for managing wifi
    iwd # Wireless daemon for Linux
  ];
}
