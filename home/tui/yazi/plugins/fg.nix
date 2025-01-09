{pkgs, ...}: {
  programs.yazi = {
    plugins = {
      fg = pkgs.yaziPlugins.fg;
    };

    keymap.manager.prepend_keymap = [
      {
        on = ["f" "g"];
        run = "plugin fg";
        desc = "Find file by content (fuzzy match)";
      }
      {
        on = ["f" "G"];
        run = "plugin fg --args='rg'";
        desc = "Find file by content (ripgrep match)";
      }
      {
        on = ["f" "f"];
        run = "plugin fg --args='fzf'";
        desc = "Find file by filename";
      }
    ];
  };
}
