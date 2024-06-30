{pkgs, ...}: {
  # Define a set of font packages using Nerd Fonts with FiraCode
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode"];})
      font-awesome
      noto-fonts-emoji-blob-bin # Needed for planify
      roboto
      roboto-mono
      source-serif-pro
      symbola # Basic Latin, Greek, Cyrillic and many Symbol blocks of Unicode: Used for nh
    ];

    fontconfig = {
      defaultFonts = {
        # monospace = [ "FiraCode Mono" ];
        # sansSerif = [ "FiraCode" ];
        monospace = ["Roboto Mono"];
        sansSerif = ["Roboto"];
        serif = ["Source Serif Pro"];
      };
    };
  };
}
