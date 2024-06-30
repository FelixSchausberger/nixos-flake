{pkgs, ...}: {
  # Import configurations of graphical applications
  imports = [
    ./firefox # A web browser built from Firefox source tree
    ./gtk.nix # A multi-platform toolkit for creating graphical user interfaces
    ./mpv.nix # General-purpose media player, fork of MPlayer and mplayer2
    ./nwg-drawer.nix # Application drawer for sway Wayland compositor
    ./vscode.nix # Open source source code editor developed by Microsoft
    ./wayland
  ];

  home = {
    packages = with pkgs; [
      blender # 3D Creation/Animation/Publishing System
      # celeste # GUI file synchronization client
      libwacom # Libraries, configuration, and diagnostic tools for Wacom tablets running under Linux
      krita # A free and open source painting application
      overskride # A Bluetooth and Obex client
      qbittorrent # Featureful free software BitTorrent client
      spacedrive # An open source file manager
      # upscayl # Free and Open Source AI Image Upscaler
      # zed-editor # High-performance, multiplayer code editor
    ];
  };
}
