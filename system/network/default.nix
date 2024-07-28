{secrets, ...}: {
  networking = {
    # Required by zfs.
    # Generate with 'head -c4 /dev/urandom | od -t x4 | cut -c9-16'
    hostId = "89b3c408";

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

  environment.etc."NetworkManager/system-connections".source = "/per/etc/NetworkManager/system-connections";
}
