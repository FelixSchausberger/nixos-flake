{inputs, ...}: {
  imports = ["${inputs.impermanence}/nixos.nix"];

  environment.persistence."/per" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${inputs.self.lib.user} = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        {
          directory = ".config/cosmic/";
          # method = "symlink";
        }
        {
          directory = ".config/rclone/";
          # method = "symlink";
        }
        {
          directory = ".local/share/Steam";
          # method = "symlink";
        }
        {
          directory = ".mozilla";
          # method = "symlink";
        }
        {
          directory = ".floorp";
          mode = "0700";
        }
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".nixops";
          mode = "0700";
        }
        {
          directory = ".local/share/graveyard";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/direnv"
      ];
      files = [
        ".local/share/fish/fish_history"
      ];
    };
  };
}
