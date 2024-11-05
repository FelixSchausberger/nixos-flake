{
  config,
  hostName,
  ...
}: {
  imports = [
    ./bash.nix # GNU Bourne-Again Shell, the de facto standard shell on Linux
    ./fish.nix # Smart and user-friendly command line shell
    ./starship.nix # A minimal, blazing fast, and extremely customizable prompt
    ./zoxide.nix # A fast cd command that learns your habits
  ];

  home.shellAliases = {
    build = "nix build -L";
    cleanup = "sudo nix-collect-garbage";
    cp = "cp -rpv";
    merge = "rsync -avhu --progress";
    nixinfo = "nix-shell -p nix-info --run 'nix-info -m'";
    nixos-rebuild = "sudo nixos-rebuild --flake /per/etc/nixos/#${hostName} switch";
    pls = "sudo";
    upgrade = "nixos-rebuild --upgrade";
    repair = "sudo nix-store --verify --check-contents --repair";
    rip = "rip --graveyard /per/home/${config.home.username}/.local/share/graveyard";
  };
}
