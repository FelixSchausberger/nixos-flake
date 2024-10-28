{
  homeImports,
  inputs,
  lib,
  ...
}: let
  # Custom function to convert the first character to uppercase
  capitalizeFirstChar = str: let
    firstChar = builtins.substring 0 1 str;
    restOfString = builtins.substring 1 (builtins.stringLength str - 1) str;
  in "${lib.strings.toUpper firstChar}${restOfString}";

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
            # Capitalize the first character of the hostname
            networking.hostName = capitalizeFirstChar hostName;
            _module.args.hostName = hostName;
          }
          {
            home-manager = {
              users.fesch.imports = homeImports."fesch@${hostName}";
              extraSpecialArgs = specialArgs // {inherit hostName;};
            };
          }
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
