{
  homeImports,
  inputs,
  self,
  ...
}: let
  # Shorten paths
  inherit (inputs.nixpkgs.lib) nixosSystem;
  mod = "${self}/system";
  # Get the basic config to build on top of
  inherit (import "${self}/system") desktop laptop;
  # Get these into the module system
  specialArgs = {
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
    inherit inputs self;
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
          "${mod}/programs/hyprland.nix"
          {
            home-manager = {
              users.fesch.imports = homeImports."fesch@${hostName}";
              extraSpecialArgs = specialArgs // {inherit hostName;};
            };
          }
          inputs.scripts.nixosModules
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
        # Uncomment and adjust as needed:
        # nixos-hardware.nixosModules.microsoft-surface-pro-intel
        # {
        #   microsoft-surface.ipts.enable = true;
        #   config.microsoft-surface.surface-control.enable = true;
        # }
      ];
    };
  };
}
