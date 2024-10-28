{pkgs, ...}: {
  # Import configurations of graphical applications
  imports = [
    # ./firefox # A web browser built from Firefox source tree
    ./floorp.nix # A fork of Firefox, focused on keeping the Open, Private and Sustainable Web alive, built in Japan
    ./mpv.nix # General-purpose media player, fork of MPlayer and mplayer2
    ./planify.nix # Task manager with Todoist support
    ./spicetify.nix # Play music from the Spotify music service
    # ./vscode.nix # Open source source code editor developed by Microsoft
  ];

  home.packages = with pkgs; [
    blender # 3D Creation/Animation/Publishing System
    # calibre # Comprehensive e-book software
    # celeste # GUI file synchronization client that can sync with any cloud provider
    krita # A free and open source painting application
    libwacom # Libraries, configuration, and diagnostic tools for Wacom tablets running under Linux
    morgen # All-in-one Calendars, Tasks and Scheduler
    obsidian # A powerful knowledge base
    oculante # A minimalistic crossplatform image viewer written in Rust
    qbittorrent # Featureful free software BitTorrent client
    rnote # Simple drawing application to create handwritten notes
    spacedrive # An open source file manager
    typst # A markup-based typesetting system
    # upscayl # Free and Open Source AI Image Upscaler
    # zed-editor # High-performance, multiplayer code editor
  ];

  programs = {
    sioyek.enable = true; # A PDF viewer
  };
}
