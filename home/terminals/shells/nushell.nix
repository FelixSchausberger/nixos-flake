{
  hostName,
  self,
  windowManager,
  ...
}: {
  programs.nushell = {
    enable = true;
    envFile.text = ''
      $env.config = {
        show_banner: false
      };
    '';

    loginFile.text = ''
      if (tty) == "/dev/tty1" { ${windowManager} };
    '';

    extraConfig = ''
      $env.PATH = ($env.PATH |
      split row (char esep) |
      append /usr/bin/env
      )

      { ||
        if (which direnv | is-empty) {
            return
        }

        direnv export json | from json | default {} | load-env
      }

      def upgrade [] { sudo nix flake update ${self} | sudo nixos-rebuild --upgrade --flake "${self}/#${hostName}" switch }
    '';

    # Move to home config once https://github.com/nushell/nushell/issues/10088 is closed
    shellAliases = {
      build = "nix build -L";
      br = "broot";
      cat = "bat";
      cd = "z";
      clone = "git clone";
      # cleanup = "sudo nix store gc --debug"; # "sudo nix-collect-garbage";
      cleanup = "nh clean all";
      cp = "cp -rpv";
      fetch = "git fetch";
      ga = "git add -p"; # --interactive
      gcm = "git commit -m";
      gst = "git status";
      ll = "br -sdp";
      log = "git log --graph --abbrev-commit --all";
      merge = "rsync -avhu --progress";
      nixinfo = "nix-shell -p nix-info --run 'nix-info -m'";
      pls = "sudo";
      pull = "git pull"; # --rebase origin main
      push = "git push"; # origin main
      # rebuild = "sudo nixos-rebuild --flake ${self}/#${host} switch";
      # rebuild = "nh os switch ${self}";
      # rebuild = "nh os switch /per/etc/nixos/system/default.nix";
      rebuild = "sudo nixos-rebuild --flake /per/etc/nixos/system/default.nix switch";
      repair = "sudo nix-store --verify --check-contents --repair";
      rip = "rip --graveyard /per/share/Trash";
    };
  };
}
