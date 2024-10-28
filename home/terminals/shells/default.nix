{
  config,
  hostName,
  ...
}: {
  imports = [
    ./bash.nix # GNU Bourne-Again Shell, the de facto standard shell on Linux
    ./fish.nix # Smart and user-friendly command line shell
    # ./nushell.nix # A modern shell written in Rust
    ./starship.nix # A minimal, blazing fast, and extremely customizable prompt
    ./zoxide.nix # A fast cd command that learns your habits
  ];

  home.shellAliases = {
    build = "nix build -L";
    br = "broot";
    cat = "bat";
    # cd = "z";
    clone = "git clone";
    cleanup = "sudo nix-collect-garbage";
    cp = "cp -rpv";
    fetch = "git fetch";
    # ga = "git add -p"; # --interactive
    # gcm = "git commit -m";
    # gst = "git status";
    ll = "br -sdp";
    log = "git log --graph --abbrev-commit --all";
    merge = "rsync -avhu --progress";
    nixinfo = "nix-shell -p nix-info --run 'nix-info -m'";
    pls = "sudo";
    # pull = "git pull"; # --rebase origin main
    # push = "git push"; # origin main
    rebuild = "sudo nixos-rebuild --flake /per/etc/nixos/#${hostName} switch";
    # upgrade = "rebuild --upgrade";
    upgrade = "nix flake update --flake /per/etc/nixos";
    repair = "sudo nix-store --verify --check-contents --repair";
    rip = "rip --graveyard /per/home/${config.home.username}/.local/share/graveyard";
  };
}
