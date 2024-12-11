{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    prusa-slicer
  ];

  home.persistence."/per/home/${config.home.username}" = {
    directories = [
      {
        directory = ".config/PrusaSlicer";
      }
    ];
  };
}
