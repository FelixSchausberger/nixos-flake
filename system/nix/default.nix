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
        "pipe-operator" # Lix, use pipe-operators else
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      persistent = true;
    };
  };

  # Flakes need git
  environment.systemPackages = [pkgs.git];
}
