{pkgs, ...}: let
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);

  browser = "${pkgs.firefox}/bin/firefox";
in {
  wayland.windowManager.hyprland = {
    settings = {
      # mouse movements
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      # binds
      bind =
        [
          # See https://wiki.hyprland.org/Configuring/Binds/ for more
          "$mod, return, exec, $terminal"
          "$mod, f, exec, ${browser}"
          ", print, exec, ${pkgs.wl-clipboard}/bin/wl-copy < <(${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" -)"
          "$mod shift, q, killactive"
          "$mod shift, e, exit"
          "$mod, a, exec, ${pkgs.nwg-drawer}/bin/nwg-drawer"
          "$mod, p, exec, ${pkgs.planify}/bin/io.github.alainm23.planify.quick-add"
          # "$mod, b, exec, $terminal start --class=floating-mode ${../scripts/result/bin/rbw-fzf}"
          "$mod, v, exec, $terminal start --class=floating-mode ${../scripts/result/bin/cliphist}"
          "alt, space, togglefloating"
          "$mod, c, exec, ironbar toggle-popup ironbar clock"
          "$mod, i, exec, bash -c ${../scripts/result/bin/toggle-ironbar}"
          # "$mod, tab, exec, hyprspace, overview:toggle"
          "$mod ctrl, e, exec, ${pkgs.smile}/bin/smile --class=floating-mode"
          "$mod ctrl, c, exec, ${../scripts/result/bin/toggle-vigiland}"

          # Move focus with mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod shift, left, movewindow, l"
          "$mod shift, right, movewindow, r"
          "$mod shift, up, movewindow, u"
          "$mod shift, down, movewindow, d"

          # Notification daemon
          # "ctrl, space, exec, ${dunst} close"
          # "ctrl shift, space, exec, ${dunst} close-all"
          # "ctrl, m, exec, ${dunst} set-paused, toggle"
          # "$mod, n, exec, kill -s USR1 $(pidof ${deadd-notification-center})"
          # "$mod, m, exec, notify-send.py a --hint boolean:deadd-notification-center:true string:type:pausePopups"
          # "$mod, l, exec, notify-send.py a --hint boolean:deadd-notification-center:true string:type:unpausePopups"

          # Example special workspace (scratchpad)
          "$mod, s, togglespecialworkspace, magic"
          "$mod shift, s, movetoworkspace, special:magic"

          # Cycle through workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          "$mod shift, right, workspace, e+1"
          "$mod shift, left, workspace, e-1"
        ]
        ++ workspaces;

      bindr = [
        # launcher
        # "$mod, SUPER_L, exec, ${toggle "anyrun" true}"
        "$mod, l, exec, loginctl lock-session"
      ];

      # bindl = [
      #   # media controls
      #   ", XF86AudioPlay, exec, playerctl play-pause"
      #   ", XF86AudioPrev, exec, playerctl previous"
      #   ", XF86AudioNext, exec, playerctl next"

      #   # volume
      #   ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      #   ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      # ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, ${pkgs.avizo}/bin/volumectl -u up"
        ", XF86AudioLowerVolume, exec, ${pkgs.avizo}/bin/volumectl -u down"
        ", XF86AudioMute, exec, ${pkgs.avizo}/bin/volumectl toggle-mute"
        ", XF86AudioMicMute, exec, ${pkgs.avizo}/bin/volumectl -m toggle-mute"

        ", XF86MonBrightnessUp, exec, ${pkgs.avizo}/bin/lightctl up"
        ", XF86MonBrightnessDown, exec, ${pkgs.avizo}/bin/lightctl down"
        # backlight
        # ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
        # ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
      ];
    };

    extraConfig = ''
      # window resize
      bind = $mod, R, submap, resize
      submap = resize
        binde = , right, resizeactive, 10 0
        binde = , left, resizeactive, -10 0
        binde = , up, resizeactive, 0 -10
        binde = , down, resizeactive, 0 10
        bind = , escape, submap, reset
      submap = reset
    '';
  };
}
