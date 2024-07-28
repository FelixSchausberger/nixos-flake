let
  desktop = [
    ./core
    ./network
    ./programs
  ];

  laptop =
    desktop;
in {
  inherit desktop laptop;
}
