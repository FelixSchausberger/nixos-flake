{
  config,
  inputs,
  ...
}: {
  imports = [
    (inputs.impermanence + "/home-manager.nix")
  ];

  home.persistence."/per/home/${config.home.username}" = {
    allowOther = true;
    removePrefixDirectory = false;
    directories = [
      {
        directory = ".config/cosmic/";
        method = "symlink";
      }
      # ".gnupg"
      # ".local/share/direnv"
      ".local/share/graveyard"
      # ".mozilla"
      # {
      #   directory = ".local/share/graveyard";
      #   method = "symlink";
      # }
      # {
      #   directory = ".mozilla";
      #   method = "symlink";
      # }
      # ".ssh"
      # {
      #   directory = ".local/share/Steam";
      #   method = "symlink";
      # }
      {
        directory = ".config/rclone/";
        method = "symlink";
      }
    ];
    # files = [
    # ".config/nushell/history.txt"
    # ".config/rclone/rclone.conf"
    # ];
  };
}
