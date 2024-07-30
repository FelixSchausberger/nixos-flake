{config, ...}: let
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./programs
    ./shells
  ];

  # Add environment variables
  home.sessionVariables = {
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
}
