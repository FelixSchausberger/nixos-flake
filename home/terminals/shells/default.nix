{
  # hostName,
  # self,
  ...
}: {
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
    # cleanup = "sudo nix store gc --debug"; # "sudo nix-collect-garbage";
    cleanup = "nh clean all";
    cp = "cp -rpv";
    ll = "br -sdp";
    merge = "rsync -avhu --progress";
    nixinfo = "nix-shell -p nix-info --run 'nix-info -m'";
    pls = "sudo";
    # rebuild = "sudo nixos-rebuild --flake ${self}/#${host} switch";
    # rebuild = "nh os switch ${self} -H ${hostName}";
    repair = "sudo nix-store --verify --check-contents --repair";
    rip = "rip --graveyard /per/share/Trash";
    # upgrade = "sudo nix flake update ${self} && sudo nixos-rebuild --upgrade --flake ${self}/#${hostName} switch";
  };
}
