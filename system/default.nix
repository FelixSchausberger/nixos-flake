let
  desktop = [
    ./core
    ./hardware
    ./network
    ./programs
    ./services
  ];

  laptop =
    desktop
    ++ [
      ./services/backlight.nix
      ./services/power.nix
    ];
in {
  inherit desktop laptop;
}
