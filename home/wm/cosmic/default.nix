{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.cosmic-manager.homeManagerModules.cosmic-manager
    # ./cosmic-files.nix
    ./cosmic-term.nix
  ];

  home.packages = with pkgs; [
    cosmic-ext-ctl # CLI for COSMIC Desktop configuration management
  ];

  wayland.desktopManager.cosmic = {
    enable = true;
  };
}
