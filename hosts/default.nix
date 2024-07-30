{
  homeImports,
  inputs,
  ...
}: let
  # Shorten paths
  inherit (inputs.nixpkgs.lib) nixosSystem;
  # Get the basic config to build on top of
  inherit (import "${inputs.self}/system") desktop laptop;
  # Get these into the module system
  specialArgs = {
    secrets = builtins.fromJSON (builtins.readFile "${inputs.self}/secrets/secrets.json");
    inherit inputs;
  };

  # Function to create a configuration with the host variable
  mkHostConfig = {
    hostName,
    baseModules,
    extraModules ? [],
  }:
    nixosSystem {
      inherit specialArgs;
      modules =
        baseModules
        ++ [
          {
            networking.hostName = hostName;
            _module.args.host = hostName;
          }
          {
            home-manager = {
              users.fesch.imports = homeImports."fesch@${hostName}";
              extraSpecialArgs = specialArgs // {inherit hostName;};
            };
          }
          inputs.nixos-cosmic.nixosModules.default
          inputs.lix-module.nixosModules.default
          # inputs.scripts.nixosModules
        ]
        ++ extraModules;
    };
in {
  flake.nixosConfigurations = {
    desktop = mkHostConfig {
      hostName = "desktop";
      baseModules = desktop;
      extraModules = [./desktop];
    };

    surface = mkHostConfig {
      hostName = "surface";
      baseModules = laptop;
      extraModules = [
        ./surface
        # nixos-hardware.nixosModules.microsoft-surface-pro-intel
        # {
        #   microsoft-surface.ipts.enable = true;
        #   config.microsoft-surface.surface-control.enable = true;
        # }
      ];
    };
  };
}
