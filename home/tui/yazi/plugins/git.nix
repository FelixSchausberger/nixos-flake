{inputs, ...}: let
  # Import niv sources
  sources = import "${inputs.self}/system/nix/sources.nix";
in {
  programs.yazi = {
    plugins = {
      git = "${sources.yazi-plugins}/git.yazi";
    };

    settings.plugin.prepend_fetchers = [
      {
        id = "git";
        name = "*";
        run = "git";
      }
      {
        id = "git";
        name = "*/";
        run = "git";
      }
    ];

    initLua = ''
      require("git"):setup()
    '';
  };
}
