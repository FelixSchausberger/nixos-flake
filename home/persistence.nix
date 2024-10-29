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
      # ".gnupg"
      # ".local/share/direnv"
      ".local/share/graveyard"

      {
        directory = ".config/cosmic/";
        method = "symlink";
      }
      {
        directory = ".config/rclone/";
        method = "symlink";
      }
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        directory = ".mozilla";
        method = "symlink";
      }
      {
        directory = ".ssh";
        method = "symlink";
      }
    ];
    files = [
      ".local/share/fish/fish_history"
    ];
  };
}
