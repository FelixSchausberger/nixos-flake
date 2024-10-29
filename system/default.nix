let
  desktop = [
    ./core
    ./network.nix
    ./programs
    ./persistence.nix # Module to help you handle persistent state on systems
  ];

  laptop =
    desktop;
in {
  inherit desktop laptop;
}
