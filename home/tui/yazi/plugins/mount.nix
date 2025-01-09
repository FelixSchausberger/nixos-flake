{pkgs, ...}: {
  programs.yazi = {
    plugins = {
      mount = pkgs.yaziPlugins.mount;
    };

    keymap.manager.prepend_keymap = [
      {
        on = ["M"];
        run = "plugin mount";
        desc = "Mount manager";
      }
    ];
  };

  home.packages = with pkgs; [
    mmtui # TUI disk mount manager for TUI file managers.
  ];
}
