{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment = {
    persistence."/per/etc" = {
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/log"
      ];
      files = [
        "/etc/machine-id"
      ];
      # users.fesch = {
      #   directories = [
      #     ".config/cosmic"
      #     # "Downloads"
      #     # "Music"
      #     # "Pictures"
      #     # "Documents"
      #     # "Videos"
      #     # {
      #     #   directory = ".gnupg";
      #     #   mode = "0700";
      #     # }
      #     ".mozilla"
      #     # {
      #     #   directory = ".ssh";
      #     #   mode = "0700";
      #     # }
      #     {
      #       directory = ".local/share/keyrings";
      #       mode = "0700";
      #     }
      #     # ".local/share/direnv"
      #     ".local/share/graveyard"
      #   ];
      #   files = [
      #     ".config/nushell/history.txt"
      #     ".config/rclone/rclone.conf"
      #   ];
      # };
    };
  };
}
