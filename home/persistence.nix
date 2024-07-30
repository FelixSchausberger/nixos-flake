{inputs, ...}: {
  imports = [
    (inputs.impermanence + "/home-manager.nix")
  ];

  home.persistence."/per/home/fesch" = {
    allowOther = true;
    removePrefixDirectory = false;
    directories = [
      ".config/cosmic"
      # ".gnupg"
      # ".local/share/direnv"
      ".local/share/graveyard"
      ".mozilla"
      # ".ssh"
      # {
      #   directory = ".local/share/Steam";
      #   method = "symlink";
      # }
    ];
    files = [
      ".config/nushell/history.txt"
      ".config/rclone/rclone.conf"
    ];
  };
}
