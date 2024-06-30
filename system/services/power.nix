{
  services = {
    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    power-profiles-daemon.enable = true;

    # Battery info
    upower.enable = true;
  };
}
