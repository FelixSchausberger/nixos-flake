{ 
  config, 
  pkgs, 
  inputs, 
  ... 
}: {
  imports = [
    inputs.typix.packages.default
  ];
  # environment.systemPackages = [ typix ];
  # home.packages = [ typix ];
  programs.typix.enable = true;

  # Ensure Typst templates are cloned and available locally
  systemd.services.typst-templates = {
    description = "Sync Typst Templates";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''
        mkdir -p ${config.home.username}/.local/share/typst/packages/local/templates/1.0.0
        rsync -a ${inputs.typix.inputs.typst-templates}/ ${config.home.username}/.local/share/typst/packages/local/templates/1.0.0/
      '';

      # Periodically pull changes from the repository
      ExecStartPost = ''
        git -C ${config.home.username}/.local/share/typst/packages/local/templates/1.0.0 pull || true
      '';
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
