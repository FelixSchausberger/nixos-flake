{pkgs, ...}: {
  programs.yazi = {
    plugins = {
      eza-preview = pkgs.yaziPlugins.eza-preview;
    };
  };
}
