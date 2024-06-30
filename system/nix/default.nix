{pkgs, ...}: {
  imports = [
    ./nh.nix
    ./nixpkgs.nix
    ./substituters.nix
  ];

  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  # Flakes need git
  environment.systemPackages = [pkgs.git];
}
