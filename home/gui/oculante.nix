{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    oculante
  ];

  home-manager.users.${inputs.self.lib.user} = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "image/gif" = "oculante.desktop";
        "image/jpeg" = "oculante.desktop";
        "image/png" = "oculante.desktop";
      };
    };
  };
}
