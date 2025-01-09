{
  config,
  pkgs,
  lib,
  ...
}: {
  options.programs.yazelix = {
    enable = lib.mkEnableOption "yazelix";
  };

  config = lib.mkIf config.programs.yazelix.enable {
    home.packages = with pkgs; [
      # Required dependencies
      yazi
      zellij
      nushell
      helix
    ];

    # Ensure configuration directory exists
    home.file.".config/yazelix/.keep".text = "";
  };
}
