{pkgs, ...}: {
  programs.bat = {
    enable = true;

    extraPackages = with pkgs.bat-extras; [
      batgrep
    ];
  };

  home.shellAliases = {
    rg = "batgrep";
  };
}
