{self, ...}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${self}/home/modules/wm/wallpaper.jpg
    wallpaper = ,${self}/home/modules/wm/wallpaper.jpg
    splash = false
  '';
}
