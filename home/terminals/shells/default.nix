{
  imports = [
    ./bash.nix # GNU Bourne-Again Shell, the de facto standard shell on Linux
    ./nushell.nix # A modern shell written in Rust
    ./starship.nix # A minimal, blazing fast, and extremely customizable prompt
    ./zoxide.nix # A fast cd command that learns your habits
  ];

  home.shellAliases = {
    build = "nix build -L";
    br = "broot";
    cat = "bat";
    # cd = "z";
    clone = "git clone";
    cleanup = "nh clean all"; # "sudo nix store gc --debug"; # "sudo nix-collect-garbage";
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
    rebuild = "nh os switch /per/etc/nixos"; # "sudo nixos-rebuild --flake ${self}/#${host} switch";
    upgrade = "nh os switch -u /per/etc/nixos";
    repair = "sudo nix-store --verify --check-contents --repair";
    rip = "rip --graveyard .local/share/graveyard";
  };
}
