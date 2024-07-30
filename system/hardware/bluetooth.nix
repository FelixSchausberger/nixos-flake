{
  hardware.bluetooth.enable = true;

  systemd.tmpfiles.rules = [
    "L /var/lib/bluetooth - - - - /per/var/lib/bluetooth"
  ];
}
