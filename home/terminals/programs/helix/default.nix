{
  pkgs,
  helix-master,
  ...
}: {
  imports = [./languages.nix];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = helix-master.packages.${pkgs.system}.default;
    extraPackages = [pkgs.helix-gpt];
    settings = {
      editor = {
        gutters = ["diff" "line-numbers" "spacer" "diagnostics"];
        cursorline = true;
        # cursor-shape = {
        #   normal = "block";
        #   insert = "bar";
        #   select = "underline";
        # };
        true-color = true;
        lsp.display-messages = true;
        mouse = false;
        soft-wrap = {
          enable = true;
          wrap-indicator = "";
        };
      };
      theme = "base16_transparent";
      keys = {
        insert = {esc = ["collapse_selection" "normal_mode"];};
        normal = {
          esc = ["collapse_selection" "normal_mode"];
          X = "extend_line_above";
          a = ["append_mode" "collapse_selection"];
          g.q = ":reflow";
          i = ["insert_mode" "collapse_selection"];
          ret = ["move_line_down" "goto_line_start"];
          space = {
            w = ":write";
            q = ":quit";
          };
        };
        select = {esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];};
      };
    };
  };
}
