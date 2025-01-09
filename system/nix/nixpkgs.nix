{
  inputs,
  pkgs,
  ...
}: let
  # Import niv sources
  sources = import ./sources.nix;

  # Create an overlay for niv-managed packages
  nivOverlay = final: prev: {
    lumen = final.callPackage ./pkgs/lumen {inherit sources;};
    mmtui = final.callPackage ./pkgs/mmtui {inherit sources;};

    yaziPlugins = {
      clipboard = sources."clipboard.yazi";
      eza-preview = sources."eza-preview.yazi";
      fg = sources."fg.yazi";
      mount = sources."mount.yazi";
    };
  };
in {
  imports = [
    inputs.lix-module.nixosModules.default
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      allowBroken = true;
    };
    overlays = [
      inputs.nur.overlays.default
      nivOverlay
    ];
  };

  environment.systemPackages = [
    pkgs.niv # Easy dependency management for Nix projects
  ];
}
