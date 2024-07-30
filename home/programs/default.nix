{pkgs, ...}: {
  # Import configurations of graphical applications
  imports = [
    ./firefox.nix # A web browser built from Firefox source tree
    ./mpv.nix # General-purpose media player, fork of MPlayer and mplayer2
    ./planify.nix # Task manager with Todoist support
    ./vscode.nix # Open source source code editor developed by Microsoft
  ];

  home.packages = with pkgs; [
    blender # 3D Creation/Animation/Publishing System
    krita # A free and open source painting application
    libwacom # Libraries, configuration, and diagnostic tools for Wacom tablets running under Linux
    obsidian # A powerful knowledge base
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
