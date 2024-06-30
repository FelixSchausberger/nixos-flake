{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "backup";

    extraSpecialArgs = {
      secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets/secrets.json");
    };
  };
}
