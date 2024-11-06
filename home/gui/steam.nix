{
  config,
  inputs,
  ...
}: {
  imports = [
    (inputs.impermanence + "/home-manager.nix")  
  ];
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  home.persistence."/per/home/${config.home.username}" = {
    directories = [
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
  };
}
