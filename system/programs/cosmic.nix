{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-cosmic.nixosModules.default
    "${inputs.impermanence}/nixos.nix"
  ];

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cosmic-player # WIP COSMIC media player.
    cosmic-reader # WIP COSMIC PDF reader.
    cosmic-ext-applet-clipboard-manager # Clipboard manager for COSMIC.
    cosmic-ext-applet-emoji-selector # Emoji Selector for COSMIC DE.
    # cosmic-ext-applet-external-monitor-brightness # Change brightness of external monitors via DDC/CI protocol.
    cosmic-ext-examine # A system information viewer for the COSMIC desktop.
    cosmic-ext-tweaks # A tweaking tool for the COSMIC desktop.
  ];

  # For the clipboard manager to work zwlr_data_control_manager_v1 protocol needs to be available
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  environment.persistence."/per" = {
    users.${inputs.self.lib.user} = {
      directories = [
        {
          directory = ".config/cosmic/";
        }
      ];
    };
  };
}
