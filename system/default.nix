let
  desktop = [
    ./core
    # ./hardware
    ./network.nix
    ./persistence.nix
    ./programs
  ];

  laptop =
    desktop;
in {
  inherit desktop laptop;
}
