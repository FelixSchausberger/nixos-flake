{pkgs, ...}: 
# let
#   # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
#   workspaces = builtins.concatLists (builtins.genList (
#       x: let
#         ws = let
#           c = (x + 1) / 10;
#         in
#           builtins.toString (x + 1 - (c * 10));
#       in [
#         "Mod+${ws}".action, focus-workspace ${toString (x + 1)}"
#         "Mod+SHIFT+${ws}, move-column-to-workspace ${toString (x + 1)}"
#       ]
#     )
#     10);
# in 
{
    # https://gist.github.com/zkat/beefc09ad8191dc7077290feceb19582
    programs.niri.settings.binds = with config.lib.niri.actions; {
      "Mod+Return".action = spawn "${pkgs.wezterm}/bin/wezterm";
      "Mod+F".action = spawn "${pkgs.spacedrive}/bin/spacedrive";
      # "Mod+1".action = focus-workspace 1;

      "Mod+Plus".action = set-column-width "+10%";

      "Mod+L".action = loginctl lock-session;
      
      # "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
      # "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
      "XF86AudioRaiseVolume".action = spawn "${pkgs.avizo}/bin/volumectl" "-u" "up";
      "XF86AudioLowerVolume".action = spawn "${pkgs.avizo}/bin/volumectl" "-u" "down";
      "XF86AudioMute".action = spawn "${pkgs.avizo}/bin/volumectl" "toggle-mute";
      "XF86AudioMicMute".action = spawn "${pkgs.avizo}/bin/volumectl" "-m" "toggle-mute";

      "XF86MonBrightnessUp".action = spawn "${pkgs.avizo}/bin/lightctl" "up";
      "XF86MonBrightnessDown".action = spawn "${pkgs.avizo}/bin/lightctl" "down";
    }
}
