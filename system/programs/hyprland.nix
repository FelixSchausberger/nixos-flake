{inputs, ...}: {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  environment.variables.NIXOS_OZONE_WL = "1"; # For electron apps

  # Enable hyprland and required options
  programs.hyprland.enable = true;
}
