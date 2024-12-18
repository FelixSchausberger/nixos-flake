{inputs, ...}: {
  imports = [
    "${inputs.impermanence}/nixos.nix"
  ];

  virtualisation.waydroid.enable = true;

  environment.persistence."/per" = {
    hideMounts = true;
    directories = [
      "/var/lib/waydroid"
    ];

    users.${inputs.self.lib.user} = {
      directories = [
        {
          directory = ".local/share/waydroid";
          mode = "0700";
        }
      ];
    };
  };
}
