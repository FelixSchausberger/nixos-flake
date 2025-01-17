{
  programs.niri.settings.window-rules = [
    {
      geometry-corner-radius = let
        radius = 4.0;
      in {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };
      clip-to-geometry = true;
      draw-border-with-background = false;

      # border = {
      #   enable = true;
      #   active.color = "#B2CFCF";
      # };

      # focus-ring = {
      #   enable = false;
      # };
    }
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
}
