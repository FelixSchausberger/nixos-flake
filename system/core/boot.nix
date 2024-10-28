{
  config,
  lib,
  # pkgs,
  ...
}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false; # Set to true allows gaining root access by passing init=/bin/sh as a kernel parameter
        consoleMode = "max";
        configurationLimit = 3;
      };

      grub.device = "/dev/nvme0n1";

      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    supportedFilesystems = ["ntfs" "zfs"];
    initrd = {
      # Enable wipe-on-boot
      # Might ned mkAfter or might need mkBefore
      # Remember to add 'lib' as a param to the enclosing function
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/eyd/root@blank
      '';
    };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages; # pkgs.zfs.latestCompatibleLinuxPackages;
    # kernelPackages = pkgs.linuxPackages_6_6;
    kernelParams = ["nohibernate" "quiet" "udev.log_level=3"];
  };

  services.zfs.autoScrub.enable = true;
}
