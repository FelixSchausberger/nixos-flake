{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    oculante
  ];

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/gif" = "Oculante.desktop";
        "image/jpg" = "Oculante.desktop";
        "image/jpeg" = "Oculante.desktop";
        "image/png" = "Oculante.desktop";
      };
    };

    desktopEntries.oculante = {
      name = "Oculante";
      exec = "${pkgs.oculante}/bin/oculante";
    };
  };
}
