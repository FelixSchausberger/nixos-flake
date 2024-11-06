{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false; # Set to true allows gaining root access by passing init=/bin/sh as a kernel parameter
        consoleMode = "max";
        configurationLimit = 10;
      };

      grub.device = "/dev/nvme0n1";

      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    supportedFilesystems = ["ntfs" "zfs"];
    initrd = {
      systemd.enable = true;

      # systemd in initrd requires a service instead of a command
      systemd.services.reset = {
        description = "reset root filesystem";
        wantedBy = ["initrd.target"];
        after = ["zfs-import.target"];
        before = ["sysroot.mount"];
        path = with pkgs; [zfs];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = "zfs rollback -r rpool/eyd/root@blank";
      };
    };

    kernelParams = ["nohibernate" "quiet" "udev.log_level=3"];
  };

  services.zfs.autoScrub.enable = true;
}
