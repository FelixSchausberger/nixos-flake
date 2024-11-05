{
  inputs,
  secrets,
  ...
}: {
  users.users = {
    ${inputs.self.lib.user} = {
      isNormalUser = true;
      description = "Felix Schausberger";
      extraGroups = ["networkmanager" "video" "wheel"];
      password = "${secrets.${inputs.self.lib.user}.password}";
    };
  };

  services.getty.autologinUser = inputs.self.lib.user;
}
