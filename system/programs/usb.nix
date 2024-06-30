{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    usbutils
    udisks
  ];

  services = {
    gvfs.enable = true;
  };
}
