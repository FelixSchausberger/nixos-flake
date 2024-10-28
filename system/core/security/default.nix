{
  imports = [
    ./sops.nix
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
}
