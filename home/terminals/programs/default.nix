{pkgs, ...}: {
  imports = [
    ./bat.nix # A cat clone with syntax highlighting and Git integration
    ./broot.nix # An interactive tree view, a fuzzy search, a balanced BFS descent
    ./direnv.nix # A shell extension that manages your environment
    ./eza.nix # A modern, maintained replacement for ls
    ./fd.nix # A simple, fast and user-friendly alternative to find
    ./fzf.nix # A command-line fuzzy finder written in Go
    ./git.nix # Distributed version control system
    ./helix
    # ./i2p.nix # Applications and router for I2P, anonymity over the Internet
    ./nix.nix # Nix tooling
    ./rbw.nix # Unofficial command line client for Bitwarden
    ./rclone.nix # Sync files and directories to and from major cloud storage
    ./tealdeer.nix # A very fast implementation of tldr
    ./thefuck.nix # Magnificent app which corrects your previous console command
    ./yazi
  ];

  programs = {
    bottom.enable = true; # A cross-platform graphical process/system monitor
    home-manager.enable = true; # A Nix-based user environment configurator
    nix-index.enable = true; # A files database for nixpkgs
  };

  home.packages = with pkgs; [
    bat
    ouch # A CLI for easily compressing and decompressing files and directories
    procs # A modern replacement for ps
    quickemu # Quickly create and run virtual machines
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    rm-improved # Replacement for rm
  ];

  services = {
    lorri.enable = true; # Your project's nix-env
  };
}
