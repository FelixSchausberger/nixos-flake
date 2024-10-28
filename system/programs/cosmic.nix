{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cosmic-player
    cosmic-reader
    cosmic-ext-applet-clipboard-manager
    cosmic-ext-applet-emoji-selector
    # cosmic-ext-applet-external-monitor-brightness
    cosmic-ext-examine
    cosmic-ext-tweaks
  ];

  # For the clipboard manager to work zwlr_data_control_manager_v1 protocol needs to be available
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
}
