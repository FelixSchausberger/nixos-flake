{inputs, ...}: let
  # Import niv sources
  sources = import "${inputs.self}/system/nix/sources.nix";
in {
  programs.yazi = {
    plugins = {
      starship = sources.starship-yazi;
    };

    initLua = ''
      require("starship"):setup()
    '';
  };
}
