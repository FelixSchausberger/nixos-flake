{ lib, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false; # Set to true allows gaining root access by passing init=/bin/sh as a kernel parameter
        consoleMode = "max";
      };

      grub.device = "/dev/sda"; 

      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    supportedFilesystems = [ "ntfs" "zfs" ];
    initrd = {
      systemd = {
	enable = lib.mkDefault true;
        
	services.rollback = {
	  description = "Rollback root filesystem to a pristine state on boot";
	  wantedBy = [
	    "initrd.target"
	  ];
	  after = [
	    "zfs-import-zpool.service"
	  ];
	  before = [
	    "sysroot.mount"
	  ];
	  path = with pkgs; [
	    zfs
	  ];
	  unitConfig.DefaultDependencies = "no";
	  serviceConfig.Type = "oneshot";
	  script = ''
	    zfs rollback -r rpool/eyd/root@blank && echo "  >> >> rollback complete << <<"
	  '';
	};
      };

      # Enable wipe-on-boot
      # Might ned mkAfter or might need mkBefore
      # Remember to add 'lib' as a param to the enclosing function
      # postDeviceCommands = lib.mkAfter ''
      #   zfs rollback -r rpool/eyd/root@blank
      # '';
    };

    kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;
    kernelParams = [ "quiet" "udev.log_level=3" ];
  };
}
