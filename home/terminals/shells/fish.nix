{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      direnv hook fish | source
    '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
    ];
  };

  xdg.configFile."fish/functions/fish_prompt.fish".text = ''
    function fish_prompt
      set -l nix_shell_info (
          if test -n "$IN_NIX_SHELL"
              echo -n "<nix-shell> "
          end
      )

      set_color $fish_color_cwd
      echo -n (prompt_pwd)
      set_color normal
      echo -n -s " $nix_shell_info ~>"
    end
  '';
}
