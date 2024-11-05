{inputs, ...}: {
  imports = [
    inputs.nix-index-db.hmModules.nix-index
    ./persistence.nix
  ];

  home = {
    homeDirectory = "/home/${inputs.self.lib.user}";
    username = inputs.self.lib.user;

    sessionVariables = {
      XDG_RUNTIME_DIR = "/run/user/$UID";
    };

    # Specify Home Manager release version
    stateVersion = "24.05";
  };

  # Let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
