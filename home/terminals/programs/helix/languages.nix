{pkgs, ...}: {
  programs.helix.languages = {
    # the language-server option currently requires helix from the master branch at https://github.com/helix-editor/helix/
    language-server.gpt = with pkgs.nodePackages; {
      command = "${helix-gpt}/bin/helix-gpt";
    };

    # language-server.typescript-language-server = with pkgs.nodePackages; {
    #   command = "${typescript-language-server}/bin/typescript-language-server";
    #   args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
    #   language-id = "javascript";
    # };
  
    language = [
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
        language-servers = [
          "gpt"
        ];

      }
      {
        name = "toml";
        auto-format = true;
        formatter.command = "${pkgs.taplo}/bin/taplo fmt";
      }
      # {
      #   name = "typescript";
      #   language-servers = [
      #       "ts",
      #       "gpt"
      #   ];
      # }
      {
        name = "typst";
        auto-format = true;
      }
      {
        name = "yaml";
        auto-format = true;
      }
    ];
  };
}
