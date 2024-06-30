{secrets, ...}: {
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    hostId = "fb0ad2a7";

    # WiFi configuration
    wireless = {
      networks = {
        Pretty-Fly-For-A-WiFi = {
          psk = "${secrets.wifi.pretty-fly-for-a-wifi}";
        };

        Hochbau-Talstation = {
          psk = "${secrets.wifi.hochbau-talstation}";
        };
      };
    };
  };

  environment.etc."NetworkManager/system-connections" = {
    source = "/per/etc/NetworkManager/system-connections/";
  };
}
