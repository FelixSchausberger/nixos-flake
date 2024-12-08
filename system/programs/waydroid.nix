{
  virtualisation.waydroid.enable = true;

  environment.persistence."/per" = {
    users.${inputs.self.lib.user} = {
      directories = [
        {
          "/var/lib/waydroid"
          # "~/.local/share/waydroid"
        }
      ];
    };
  };
}
