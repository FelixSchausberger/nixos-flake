{inputs, ...}: {
  programs.rio = {
    enable = true;

    package = inputs.unstable.legacyPackages.x86_64-linux.rio;

    # https://raphamorim.io/rio/docs/next/configuration-file/
    settings = {
      editor = "hx";

      window = {
        blur = true;
        opacity = 0.3;
      };

      fonts = {
        family = "FiraCode Nerd Font";
        size = 22;
      };
    };
  };
}
