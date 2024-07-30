{pkgs, ...}: {
  imports = [
    ./bat.nix # A cat clone with syntax highlighting and Git integration
    ./broot.nix # An interactive tree view, a fuzzy search, a balanced BFS descent
    ./direnv.nix # A shell extension that manages your environment
    ./fzf.nix # A command-line fuzzy finder written in Go
    ./git.nix # Distributed version control system
    ./helix
    # ./i2p.nix # Applications and router for I2P, anonymity over the Internet
    ./nix.nix # Nix tooling
    ./rbw.nix # Unofficial command line client for Bitwarden
    ./rclone.nix # Sync files and directories to and from major cloud storage
    ./tealdeer.nix # A very fast implementation of tldr
    ./thefuck.nix # Magnificent app which corrects your previous console command
  ];

  programs = {
    bottom.enable = true; # A cross-platform graphical process/system monitor
    home-manager.enable = true; # A Nix-based user environment configurator
    nix-index.enable = true; # A files database for nixpkgs
  };

  home.packages = with pkgs; [
    fd # A simple, fast and user-friendly alternative to find
    ouch # A CLI for easily compressing and decompressing files and directories
    procs # A modern replacement for ps
    quickemu # Quickly create and run virtual machines
    rm-improved # Replacement for rm
    ripgrep-all # Ripgrep, but also search in PDFs, E-Books, Office documents, ...
    # wl-clipboard # Command-line copy/paste utilities for Wayland
  ];

  services = {
    cliphist.enable = true; # Wayland clipboard manager
    lorri.enable = true; # Your project's nix-env
  };
}
