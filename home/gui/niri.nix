{
  config,
  inputs,
  pkgs,
  ...
}: let
  makeCommand = command: {
    command = [command];
  };
in {
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.bash = {
    enable = true;

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
      binds = with config.lib.niri.actions;
      # let
      #   sh = spawn "sh" "-c";
      # in
        {
          "Mod+T".action = spawn "cosmic-term";
          "Mod+D".action = spawn "cosmic-launcher";
          "Mod+Shift+D".action = spawn "cosmic-app-library";
          "Mod+Alt+L".action = spawn "cosmic-greeter";

          "Mod+Shift+I".action = show-hotkey-overlay;

          "Mod+Shift+E".action = quit;
          "Mod+Ctrl+Shift+E".action = quit {skip-confirmation = true;};

          "Mod+Q".action = close-window;
          "Mod+S".action = switch-preset-column-width;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;

          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;
          "Mod+C".action = center-column;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Plus".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Plus".action = set-window-height "+10%";

          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+J".action = focus-workspace-down;
          "Mod+K".action = focus-workspace-up;
          "Mod+Left".action = focus-column-left;
          "Mod+Right".action = focus-column-right;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;

          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+L".action = move-column-right;
          "Mod+Shift+K".action = move-column-to-workspace-up;
          "Mod+Shift+J".action = move-column-to-workspace-down;

          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        };

      spawn-at-startup = [
        (makeCommand "${pkgs.cosmic-ext-alternative-startup}/bin/cosmic-ext-alternative-startup")
        {
          command = [
            "cosmic-panel"
          ];
        }
      ];

      # layout = {
      #   focus-ring.enable = false;
      #   border = {
      #     enable = true;
      #     width = 1;
      #     active.gradient = {
      #       angle = 45;
      #       relative-to = "workspace-view";
      #       from = "#e55812";
      #       to = "#e6aa1f";
      #     };
      #     inactive.color = "#412e4e";
      #   };

      #   preset-column-widths = [
      #     {proportion = 1.0 / 3.0;}
      #     {proportion = 1.0 / 2.0;}
      #     {proportion = 2.0 / 3.0;}
      #     {proportion = 1.0;}
      #   ];
      #   default-column-width = {proportion = 1.0 / 2.0;};

      #   gaps = 8;
      #   struts = {
      #     left = 0;
      #     right = 0;
      #     top = 0;
      #     bottom = 0;
      #   };
      # };

      animations.shaders.window-resize = ''
        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
            vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

            vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
            vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

            // We can crop if the current window size is smaller than the next window
            // size. One way to tell is by comparing to 1.0 the X and Y scaling
            // coefficients in the current-to-next transformation matrix.
            bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
            bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

            vec3 coords = coords_stretch;
            if (can_crop_by_x)
                coords.x = coords_crop.x;
            if (can_crop_by_y)
                coords.y = coords_crop.y;

            vec4 color = texture2D(niri_tex_next, coords.st);

            // However, when we crop, we also want to crop out anything outside the
            // current geometry. This is because the area of the shader is unspecified
            // and usually bigger than the current geometry, so if we don't fill pixels
            // outside with transparency, the texture will leak out.
            //
            // When stretching, this is not an issue because the area outside will
            // correspond to client-side decoration shadows, which are already supposed
            // to be outside.
            if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
                color = vec4(0.0);
            if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
                color = vec4(0.0);

            return color;
        }
      '';

      window-rules = [
        {
          # Add rounded corners
          geometry-corner-radius = let
            radius = 12.0;
          in {
            bottom-left = radius;
            bottom-right = radius;
            top-left = radius;
            top-right = radius;
          };
          clip-to-geometry = true;
        }
        {
          matches = [{app-id = "org.telegram.desktop";}];
          block-out-from = "screencast";
        }
      ];

      prefer-no-csd = true; # Whether to prefer server-side decorations (SSD) over client-side decorations (CSD).
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
