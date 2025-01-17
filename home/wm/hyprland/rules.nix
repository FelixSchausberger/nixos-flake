{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "opacity 0.9 0.8, ^(cosmic-term)$"
      "float, ^(floating-mode)$"
      "float, ^(Steam)$"
      "float, title:^(Media viewer)$" # Telegram media viewer

      # Bitwarden extension
      "float, title:^(.*Bitwarden Password Manager.*)$"

      # Allow tearing in games
      "immediate, class:^(osu\!|cs2)$"

      # Make Firefox/Zen PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # Throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(Zen — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # Start Spotify and YouTube Music in ws9
      "workspace 9 silent, title:^(Spotify( Premium)?)$"
      # "workspace 9 silent, title:^(YouTube Music)$"

      # Fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"
    ];
  };
}
