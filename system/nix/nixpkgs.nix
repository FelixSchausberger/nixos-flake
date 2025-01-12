{
  inputs,
  pkgs,
  ...
}: let
  # Import niv sources
  sources = import ./sources.nix;
  # Create an overlay for niv-managed packages
  nivOverlay = final: prev: {
    cosmic-ext-alternative-startup = final.callPackage ./pkgs/cosmic-ext-alternative-startup {inherit sources;};
    lumen = final.callPackage ./pkgs/lumen {inherit sources;};
    yazelix = final.callPackage ./pkgs/yazelix {
      inherit sources;
      inherit (final) yazi zellij nushell helix;
    };
    yaziPlugins = {
      clipboard = sources."clipboard.yazi";
      eza-preview = sources."eza-preview.yazi";
      fg = sources."fg.yazi";
      mount = sources."mount.yazi";
      mmtui = pkgs.callPackage "${inputs.self}/system/nix/pkgs/mmtui" {inherit sources;};
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
      inputs.niri.overlays.niri
      inputs.nur.overlays.default
      nivOverlay
    ];
  };
  environment.systemPackages = with pkgs; [
    niv # Easy dependency management for Nix projects
    yazelix
  ];
}
