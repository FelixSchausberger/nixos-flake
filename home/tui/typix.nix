{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  # Typst templates directory
  templatesDir = "${config.home.homeDirectory}/.local/share/typst/packages/local/templates/1.0.0";
in {
  home.packages = [
    inputs.typix
  ];

  # Clone or update Typst templates during activation
  home.activation.typst-templates = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${templatesDir}
    if [ ! -d "${templatesDir}/.git" ]; then
      ${pkgs.git}/bin/git clone https://github.com/typst/templates.git ${templatesDir}
    else
      ${pkgs.git}/bin/git -C ${templatesDir} pull
    fi
  '';

  # Systemd user service to keep templates updated
  systemd.user.services.typst-templates-update = {
    description = {text = "Update Typst Templates";};
    wantedBy = {targets = ["default.target"];};
    serviceConfig = {
      ExecStart = "${pkgs.git}/bin/git -C ${templatesDir} pull";
      WorkingDirectory = templatesDir;
    };
  };

  home.persistence."/per/home/${config.home.username}" = {
    directories = [
      {
        directory = ".local/share/typst/packages/local/templates/1.0.0";
      }
    ];
  };
}
