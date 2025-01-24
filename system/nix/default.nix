{pkgs, ...}: {
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
  ];

  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators" # Used by lix, for nix use "pipe-operators"
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      persistent = true;
    };
  };

  environment.systemPackages = [
    pkgs.git # Flakes need git
  ];
}
