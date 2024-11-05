{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq"];
    scripts = [pkgs.mpvScripts.mpris];
  };

  home = {
    packages = with pkgs; [
      ffmpeg
      # yt-dlp
      # mediainfo
    ];
  };
}
