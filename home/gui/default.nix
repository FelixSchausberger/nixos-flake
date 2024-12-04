{pkgs, ...}: {
  # Import configurations of graphical applications
  imports = [
    ./calibre.nix # Comprehensive e-book software
    ./firefox # A web browser built from Firefox source tree
    ./mpv.nix # General-purpose media player, fork of MPlayer and mplayer2
    ./obsidian.nix # A powerful knowledge base
    ./oculante.nix # # A minimalistic crossplatform image viewer written in Rust
    ./planify.nix # Task manager with Todoist support
    ./spicetify.nix # Play music from the Spotify music service
    ./vscode.nix # Open source source code editor developed by Microsoft
  ];

  home.packages = with pkgs; [
    blender # 3D Creation/Animation/Publishing System
    # celeste # GUI file synchronization client that can sync with any cloud provider
    gimp # The GNU Image Manipulation Program
    krita # A free and open source painting application
    libwacom # Libraries, configuration, and diagnostic tools for Wacom tablets running under Linux
    # morgen # All-in-one Calendars, Tasks and Scheduler
    qbittorrent # Featureful free software BitTorrent client
    rnote # Simple drawing application to create handwritten notes
    # spacedrive # An open source file manager
    typst # A markup-based typesetting system
    # upscayl # Free and Open Source AI Image Upscaler
    # zed-editor # High-performance, multiplayer code editor
  ];

  programs = {
    sioyek.enable = true; # A PDF viewer
  };
}
