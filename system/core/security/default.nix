{inputs, ...}: {
  imports = [
    ./sops.nix
    ./ssh.nix
    "${inputs.impermanence}/nixos.nix"
  ];

  security = {
    # Allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";

    # Userland niceness
    rtkit.enable = true;

    # Don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;
  };

  services = {
    printing.browsed.enable = false; # Disable OpenPrinting CUPS vulnerabilities
  };

  environment.persistence."/per" = {
    users.${inputs.self.lib.user} = {
      directories = [
        {
          directory = ".gnupg"; # Holds GPG (GNU Privacy Guard) keys
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings"; # Where GNOME Keyring and other keyring managers store your passwords and secret keys
          mode = "0700";
        }
      ];
    };
  };
}
