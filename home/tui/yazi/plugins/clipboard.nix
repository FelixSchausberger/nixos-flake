{pkgs, ...}: {
  programs.yazi = {
    plugins = {
      clipboard = pkgs.yaziPlugins.clipboard;
    };

    keymap.manager.prepend_keymap = [
      {
        on = ["C" "y"];
        run = ["plugin clipboard"];
        desc = "Copy files to clipboard";
      }
    ];
  };
}
