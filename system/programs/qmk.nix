{pkgs, ...}: {
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    via # Yet another keyboard configurator
  ];

  services.udev.packages = [pkgs.via];
}
