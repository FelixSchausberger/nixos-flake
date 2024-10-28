let
  desktop = [
    ./core
    ./network.nix
    ./programs
  ];

  laptop =
    desktop;
in {
  inherit desktop laptop;
}
