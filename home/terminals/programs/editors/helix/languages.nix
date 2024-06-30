{pkgs, ...}: {
  programs.helix.languages.language = [
    {
      name = "bash";
      auto-format = true;
    }
    {
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.alejandra}/bin/alejandra";
    }
    {
      name = "markdown";
      auto-format = true;
    }
    {
      name = "python";
      auto-format = true;
    }
    {
      name = "rust";
      auto-format = true;
      formatter.command = "${pkgs.clippy}/bin/clippy";
    }
    {
      name = "toml";
      auto-format = true;
      formatter.command = "${pkgs.taplo}/bin/taplo fmt";
    }
    {
      name = "typst";
      auto-format = true;
    }
    {
      name = "yaml";
      auto-format = true;
    }
  ];
}
