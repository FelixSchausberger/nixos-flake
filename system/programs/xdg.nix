{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    # config.common.default = "*";
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
    wlr.enable = true;
    # Needed to make gtk apps happy.
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
