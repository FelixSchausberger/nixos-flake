{
  home = {
    homeDirectory = "/home/fesch";
    username = "fesch";

    sessionVariables = {
      XDG_RUNTIME_DIR = "/run/user/$UID";
    };

    # Specify Home Manager release version
    stateVersion = "24.05";
  };

  # Let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
