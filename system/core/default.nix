# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  hostName,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./security
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

  programs.fuse.userAllowOther = true;

  # Configure system-wide files.
  environment.etc = {
    nixos.source = "${inputs.self}";

    "ssh/ssh_host_ed25519_key.pub".source =
      if builtins.pathExists ../../hosts/${hostName}/ssh_host_ed25519_key.pub
      then ../../hosts/${hostName}/ssh_host_ed25519_key.pub
      else null;
  };

  services = {
    # Simple interprocess messaging system
    dbus.enable = true;

    # Automatic CPU speed & power optimizer
    auto-cpufreq.enable = true;
  }

  # Compresses half the ram for use as swap
  # zramSwap.enable = true;

  system.stateVersion = lib.mkDefault "25.05";
}
