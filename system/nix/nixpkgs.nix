{inputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
      allowBroken = true;
      # packageOverrides = pkgs: {
      #   unstable = import <nixpkgs-unstable> {};
      # };
    };
    overlays = [inputs.nur.overlay];
  };
}
