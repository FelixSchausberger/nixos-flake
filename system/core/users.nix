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
      openssh.authorizedKeys.keyFiles = [
        secrets.${inputs.core.lib.user}.id_ed25519
      ];
    };
  };

  services.getty.autologinUser = inputs.self.lib.user;
}
