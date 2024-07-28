{
  pkgs,
  secrets,
  ...
}: {
  users.users = {
    fesch = {
      isNormalUser = true;
      description = "Felix Schausberger";
      extraGroups = ["networkmanager" "video" "wheel"];
      shell = pkgs.nushell;
      password = "${secrets.fesch.password}";
    };
  };

  services.getty.autologinUser = "fesch";
}
