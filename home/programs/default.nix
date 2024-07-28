{pkgs, ...}: {
  # Import configurations of graphical applications
  imports = [
    ./cosmic.nix
    ./firefox # A web browser built from Firefox source tree
    ./mpv.nix # General-purpose media player, fork of MPlayer and mplayer2
    ./office
    ./vscode.nix # Open source source code editor developed by Microsoft
  ];

  home = {
    packages = with pkgs; [
      blender # 3D Creation/Animation/Publishing System
      libwacom # Libraries, configuration, and diagnostic tools for Wacom tablets running under Linux
      krita # A free and open source painting application
      qbittorrent # Featureful free software BitTorrent client
      spacedrive # An open source file manager
      # upscayl # Free and Open Source AI Image Upscaler
      # zed-editor # High-performance, multiplayer code editor
    ];
  };
}
