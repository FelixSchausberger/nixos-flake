{
  config,
  inputs,
  pkgs,
  ...
}: let
  plugins-repo = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "8d1aa6c7839b868973e34f6160055d824bb8c399";
    hash = "sha256-EuXkiK80a1roD6ZJs5KEvXELcQhhBtAH5VyfW9YFRc8=";
  };
in {
  imports = [
    ./theme/filetype.nix
    ./theme/icons.nix
    ./theme/manager.nix
    ./theme/status.nix
  ];

  # General file info
  home.packages = [
    pkgs.exiftool
  ];

  # Blazing fast terminal file manager written in Rust, based on async I/O
  programs.yazi = {
    enable = true;

    package = inputs.yazi.packages.${pkgs.system}.default;

    enableBashIntegration = config.programs.bash.enable;
    enableFishIntegration = config.programs.fish.enable;

    shellWrapperName = "y";

    settings = {
      manager = {
        layout = [1 4 3];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = config.xdg.cacheHome;
      };

      # https://yazi-rs.github.io/docs/resources/
      # https://github.com/AnirudhG07/awesome-yazi
      plugins = {
        # Execute chmod on the selected files to change their mode.
        chmod = "${plugins-repo}/chmod.yazi";

        # Preview directories using eza.
        eza-preview = pkgs.yaziPlugins.eza-preview;

        # Starship prompt plugin for Yazi.
        starship = pkgs.fetchFromGitHub {
          owner = "Rolv-Apneseth";
          repo = "starship.yazi";
          rev = "6197e4cca4caed0121654079151632f6abcdcae9";
          sha256 = "sha256-oHoBq7BESjGeKsaBnDt0TXV78ggGCdYndLpcwwQ8Zts=";
        };
      };
    };
  };
}
