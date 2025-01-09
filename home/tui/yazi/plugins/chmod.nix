{inputs, ...}: let
  # Import niv sources
  sources = import "${inputs.self}/system/nix/sources.nix";
in {
  programs.yazi = {
    plugins = {
      chmod = "${sources.yazi-plugins}/chmod.yazi";
    };

    keymap.manager.prepend_keymap = [
      {
        on = ["c" "m"];
        run = "plugin chmod";
        desc = "Chmod on selected files";
      }
    ];
  };
}
