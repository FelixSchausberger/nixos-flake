{
  config,
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    act # Run your GitHub Actions locally
    # https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/
    # graphite-cli # CLI that makes creating stacked git changes fast & intuitive
    lazygit # A simple terminal UI for git commands
    inputs.self.packages.${pkgs.system}.lumen # Instant AI Git Commit message, Git changes summary from the CLI
    pre-commit # A framework for managing and maintaining multi-language pre-commit hooks
    serie # A rich git commit graph in your terminal, like magic
  ];

  programs.git = {
    enable = true;
    userName = "Felix Schausberger";
    userEmail = "131732042+FelixSchausberger@users.noreply.github.com"; # https://help.github.com/articles/setting-your-email-in-git/
    delta = {enable = true;};
    extraConfig = {
      github.token = "${config.sops.secrets."github/token".path}";
      init.defaultBranch = "main";
      pull.rebase = true;
      credential.helper = "libsecret";
      core.editor = "${pkgs.helix}/bin/hx";
    };
  };

  home.shellAliases = {
    clone = "git clone";
    fetch = "git fetch";
    ga = "git add -p"; # --interactive
    gcm = "git commit -m";
    gst = "git status";
    log = "git log --graph --abbrev-commit --all";
    # prune = "git filter-branch --index-filter \"git rm -f --cached --ignore-unmatch $1/*\" --prune-empty --tag-name-filter cat -- --all"
    pull = "git pull"; # --rebase origin main
    push = "git push"; # origin main
  };
}
