{
  config,
  hostName,
  ...
}: {
  programs.nushell = {
    enable = true;
    envFile.text = ''
      $env.config = {
        show_banner: false
      };
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

      def --env y [...args] {
      	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
      	yazi ...$args --cwd-file $tmp
      	let cwd = (open $tmp)
      	if $cwd != "" and $cwd != $env.PWD {
      		cd $cwd
      	}
      	rm -fp $tmp
      }
    '';

    # Move to home config once https://github.com/nushell/nushell/issues/10088 is closed
    shellAliases = {
      build = "nix build -L";
      br = "broot";
      cat = "bat";
      cd = "z";
      clone = "git clone";
      cleanup = "sudo nix-collect-garbage";
      cp = "cp -rpv";
      fetch = "git fetch";
      ga = "git add -p"; # --interactive
      gcm = "git commit -m";
      gst = "git status";
      ll = "br -sdp";
      log = "git log --graph --abbrev-commit --all";
      merge = "sudo rsync -avhu --progress";
      nixinfo = "nix-shell -p nix-info --run 'nix-info -m'";
      pls = "sudo";
      pull = "git pull"; # --rebase origin main
      push = "git push"; # origin main
      rebuild = "sudo nixos-rebuild --flake /per/etc/nixos/#${hostName} switch";
      # upgrade = "rebuild --upgrade";
      upgrade = "nix flake update --flake /per/etc/nixos";
      repair = "sudo nix-store --verify --check-contents --repair";
      rip = "rip --graveyard /per/home/${config.home.username}/.local/share/graveyard";
    };
  };
}
