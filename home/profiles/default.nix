{
  # self,
  inputs,
  ...
}: let
  # Get these into the module system
  extraSpecialArgs = {inherit inputs;}; # self;};

  homeImports = {
    "fesch@desktop" = [
      ../.
      ./desktop
    ];
    "fesch@surface" = [
      ../.
      ./surface
    ];
  };

  inherit (inputs.hm.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  # We need to pass this to NixOS' HM module
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "fesch_desktop" = homeManagerConfiguration {
        modules = homeImports."fesch@desktop";
        inherit pkgs extraSpecialArgs;
      };

      "fesch_surface" = homeManagerConfiguration {
        modules = homeImports."fesch@surface";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
