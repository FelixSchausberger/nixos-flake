{
  inputs,
  pkgs,
  ...
}: let
  # Helper function to create command objects for spawn-at-startup
  makeCommand = command: {
    command = [command];
  };
in {
  imports = [
    inputs.niri.homeModules.niri
    ./binds.nix
    ./rules.nix
  ];

  programs.bash = {
    enable = true;

    # Auto-start niri when logging into TTY1
    bashrcExtra = ''
      # Check if on TTY1 and start cosmic-session if necessary
      if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        pidof mylock > /dev/null || exec cosmic-session niri
      fi
    '';
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;

    settings = {
      # Define named workspaces
      workspaces = {
        "browser" = {
          # Default browser workspace, no specific output constraints
        };
      };

      # Automatically start applications on login
      spawn-at-startup = [
        # Start Cosmic desktop components
        (makeCommand "${pkgs.cosmic-ext-alternative-startup}/bin/cosmic-ext-alternative-startup")
        (makeCommand "${pkgs.cosmic-panel}/bin/cosmic-panel")
        (makeCommand "${pkgs.gammastep}/bin/gammastep")

        # Start Firefox in the browser workspace
        # {
        #   command = ["firefox"];
        #   workspace = "browser";
        # }
      ];

      layout.always-center-single-column = true;

      # General preferences
      prefer-no-csd = true; # Prefer server-side decorations over client-side
      hotkey-overlay.skip-at-startup = true; # Don't show hotkey overlay on startup
    };
  };
}
