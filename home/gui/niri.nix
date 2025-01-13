{
  config,
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

      # Keybindings organized by function
      binds = with config.lib.niri.actions; {
        #
        # Application Launchers
        #
        "Mod+T".action = spawn "cosmic-term";
        "Mod+D".action = spawn "cosmic-launcher";
        "Mod+Shift+D".action = spawn "cosmic-app-library";
        "Mod+Alt+L".action = spawn "cosmic-greeter";

        #
        # Scratchpad Controls
        # These spawn floating windows with specific titles that match window rules
        #
        "Mod+Alt+T".action = spawn "cosmic-term --title scratchpad-terminal";
        "Mod+Alt+S".action = spawn "spotify --title scratchpad-spotify";
        "Mod+Alt+P".action = spawn "planify --title scratchpad-planify";
        "Mod+Alt+O".action = spawn "obsidian --title scratchpad-obsidian";

        #
        # Window Management
        #
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        
        # Column Management
        "Mod+S".action = switch-preset-column-width;
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
        "Mod+C".action = center-column;

        # Size Adjustments
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Plus".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Plus".action = set-window-height "+10%";

        #
        # Navigation
        #
        # Focus Movement
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-workspace-down;
        "Mod+K".action = focus-workspace-up;
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        
        # Alternative Workspace Navigation
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;

        #
        # Window/Column Movement
        #
        # Column Movement
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+K".action = move-column-to-workspace-up;
        "Mod+Shift+J".action = move-column-to-workspace-down;
        
        # Alternative Column Movement
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;
        "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        
        # Workspace Movement
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;
        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;

        # Monitor Movement
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;

        #
        # System Controls
        #
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+Shift+E".action = quit;
        "Mod+Ctrl+Shift+E".action = quit {skip-confirmation = true;};
      };

      # Automatically start applications on login
      spawn-at-startup = [
        # Start Cosmic desktop components
        (makeCommand "${pkgs.cosmic-ext-alternative-startup}/bin/cosmic-ext-alternative-startup")
        {
          command = ["cosmic-panel"];
        }
        # Night light functionality
        {
          command = ["gammastep"];
        }
        # Start Firefox in the browser workspace
        {
          command = ["firefox"];
          workspace = "browser";
        }
      ];

      # Window rules for different applications and scenarios
      window-rules = [
        # Scratchpad terminal configuration
        {
          matches = [
            {
              title = "scratchpad-terminal";
            }
          ];
          open-floating = true;
        }
        # Scratchpad spotify configuration
        {
          matches = [
            {
              title = "scratchpad-spotify";
            }
          ];
          open-floating = true;
        }
        # Scratchpad planify configuration
        {
          matches = [
            {
              title = "scratchpad-planify";
            }
          ];
          open-floating = true;
        }
        # Scratchpad obsidian configuration
        {
          matches = [
            {
              title = "scratchpad-obsidian";
            }
          ];
          open-floating = true;
        }
        # Firefox workspace assignment
        {
          matches = [
            {
              app-id = "firefox";
              at-startup = true;
            }
          ];
          open-on-workspace = "browser";
        }
      ];

      # Layer-specific rules (e.g., opacity settings)
      layer-rules = [
        {
          matches = [
            {
              app-id = "cosmic-term";
            }
          ];
          background = {
            opacity = 0.8;
          };
        }
      ];

      # General preferences
      prefer-no-csd = true;  # Prefer server-side decorations over client-side
      hotkey-overlay.skip-at-startup = true;  # Don't show hotkey overlay on startup
    };
  };
}
