{
  pkgs,
  ...
}: {
  users.users = {
    fesch = {
      isNormalUser = true;
      description = "Felix Schausberger";
      extraGroups = ["networkmanager" "video" "wheel"];
      shell = pkgs.nushell;
    };
  };

  services.getty.autologinUser = "fesch";
}
