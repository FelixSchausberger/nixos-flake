{pkgs, ...}: {
  imports = [
    ./bat.nix # A cat clone with syntax highlighting and Git integration
    ./broot.nix # An interactive tree view, a fuzzy search, a balanced BFS descent
    ./cli.nix # CLI utils
    ./direnv.nix # A shell extension that manages your environment
    ./editors
    ./fzf.nix # A command-line fuzzy finder written in Go
    ./git.nix # Distributed version control system
    ./i2p.nix # Applications and router for I2P, anonymity over the Internet
    ./nix.nix # Nix tooling
    ./rbw.nix # Unofficial command line client for Bitwarden
    ./rclone.nix # Sync files and directories to and from major cloud storage
    ./tealdeer.nix # A very fast implementation of tldr
    ./thefuck.nix # Magnificent app which corrects your previous console command
    ./xdg.nix # Default programs
  ];

  programs = {
    home-manager.enable = true; # A Nix-based user environment configurator
    nix-index.enable = true; # A files database for nixpkgs
  };

  home.packages = with pkgs; [
    quickemu # Quickly create and run virtual machines
  ];

  services = {
    cliphist.enable = true; # Wayland clipboard manager
    lorri.enable = true; # Your project's nix-env
  };
}
