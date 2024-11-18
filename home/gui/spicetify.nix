{
  config,
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    (inputs.impermanence + "/home-manager.nix")
  ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle # shuffle+ (Special characters are sanitized out of extension names)
    ];

    theme = spicePkgs.themes.hazy;
  };

  home.persistence."/per/home/${config.home.username}" = {
    directories = [
      {
        directory = ".cache/spotify";
      }
    ];
  };
}
