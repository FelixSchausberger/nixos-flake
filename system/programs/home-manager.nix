{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.nur.modules.nixos.default
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
