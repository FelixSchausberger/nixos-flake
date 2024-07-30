# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  host,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./boot.nix
    ../nix
    ./security.nix
    ./users.nix
  ];

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    # Saves space
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_AT.UTF-8/UTF-8"
    ];
  };

  # Set your time zone.
  time.timeZone = lib.mkDefault "Europe/Vienna";

  # Configure system-wide files.
  environment.etc = {
    "fuse.conf".text = ''
      user_allow_other
    '';

    nixos.source = "${inputs.self}";

    "ssh/ssh_host_ed25519_key.pub".source =
      if builtins.pathExists ../../hosts/${host}/ssh_host_ed25519_key.pub
      then ../../hosts/${host}/ssh_host_ed25519_key.pub
      else null;
  };

  services.dbus.enable = true;

  # Compresses half the ram for use as swap
  # zramSwap.enable = true;

  system.stateVersion = lib.mkDefault "24.05";
}
