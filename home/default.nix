{inputs, ...}: let
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    inputs.nix-index-db.hmModules.nix-index
    ./persistence.nix # Module to help you handle persistent state on systems
  ];

  home = {
    homeDirectory = "/home/${inputs.self.lib.user}";
    username = inputs.self.lib.user;

    sessionVariables = {
      XDG_RUNTIME_DIR = "/run/user/$UID";
    
      # Clean up home directory
      LESSHISTFILE = "${cache}/less/history";
      LESSKEY = "${conf}/less/lesskey";

      WINEPREFIX = "${data}/wine";
      XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

      EDITOR = "hx";
      DIRENV_LOG_FORMAT = "";

      # Auto-run programs using nix-index-database
      NIX_AUTO_RUN = "1";
    };

    # Specify Home Manager release version
    stateVersion = "24.05";
  };

  # Let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
