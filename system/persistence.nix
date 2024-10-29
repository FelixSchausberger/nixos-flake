{inputs, ...}: {
  imports = ["${inputs.impermanence}/nixos.nix"];

  environment.persistence."/per" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
