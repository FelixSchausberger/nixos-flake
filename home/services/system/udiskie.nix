{
  services = {
    udiskie = {
      enable = true;
      settings = {
        program_options = {
          udisks_version = 2;
          tray = true;
        };
      };
    };
  };

  # Automount to /media
  home.file."/etc/udev/rules.d/99-udisks2.rules".text = ''
    # UDISKS_FILESYSTEM_SHARED
    # ==1: mount filesystem to a shared directory (/media/VolumeName)
    # ==0: mount filesystem to a private directory (/run/media/$USER/VolumeName)
    # See udisks(8)
    ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"
  '';
}
