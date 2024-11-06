{inputs, ...}: {
  imports = [
    "${inputs.impermanence}/nixos.nix"
  ];

  environment.persistence."/per" = {
    hideMounts = true;
    directories = [
      "/var/log" # Stores system and application logs essential for troubleshooting and auditing
      "/var/lib/bluetooth"
      "/var/lib/nixos" # Contains state files for NixOS, critical for preserving system and package state across reboots
      "/var/lib/systemd/coredump" # Stores core dumps from crashed applications, useful for debugging and analyzing issues
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id" # A unique identifier for the system, used by systemd and other services for consistent identification
    ];
    users.${inputs.self.lib.user} = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
      ];
    };
  };
}
