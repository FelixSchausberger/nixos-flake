{
  config,
  inputs,
  ...
}: {
  users.users = {
    "${inputs.self.lib.user}" = {
      isNormalUser = true;
      description = "Felix Schausberger";
      extraGroups = ["networkmanager" "video" "wheel"];
      # Use hashedPasswordFile instead of passwordFile
      hashedPasswordFile = config.sops.secrets."fesch/password".path;
      openssh.authorizedKeys.keyFiles = [
        "${config.sops.secrets."fesch/id_ed25519".path}"
      ];
    };
  };

  services.getty.autologinUser = inputs.self.lib.user;

  # Explicitly declare that we need these secrets
  sops.secrets."fesch/password" = {
    neededForUsers = true;
  };

  sops.secrets."fesch/id_ed25519" = {
    neededForUsers = true;
  };
}
