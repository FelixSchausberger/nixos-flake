{
  inputs,
  ...
}: {
  imports = [
    inputs.ghostty.homeModules.default
  ];

  programs.ghostty = {
    enable = true;
  };
}
