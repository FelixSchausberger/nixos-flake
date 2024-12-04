{pkgs, ...}: {
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    # via # Yet another keyboard configurator
    vial # Open-source GUI and QMK fork for configuring your keyboard in real time
  ];

  # services.udev.packages = [pkgs.via];
}
