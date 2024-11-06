{
  config,
  inputs,
  ...}:
{
  imports = [
    (inputs.impermanence + "/home-manager.nix")  
  ];
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.persistence."/per/home/${config.home.username}" = {
    directories = [
      {
        directory = ".local/share/direnv";
        mode = "0700";
      }
    ];
  };

}
