{inputs, ...}: {
  imports = [
    "${inputs.impermanence}/nixos.nix"
  ];

  environment.persistence."/per" = {
    hideMounts = true;
    directories = [
      "/var/lib/bluetooth"
    ];
  };

  hardware.bluetooth.enable = true;

  systemd.tmpfiles.rules = [
    "L /var/lib/bluetooth - - - - /per/var/lib/bluetooth"
  ];
}
