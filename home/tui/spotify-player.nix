{secrets, ...}: {
  # services.spotifyd = {
  #   enable = true;
  #   package = pkgs.spotifyd.override {withKeyring = true;};
  #   settings = {
  #     global = {
  #       username = "Alex";
  #       password = "foo";
  #     };
  #   };
  # };

  programs.spotify-player = {
    enable = true;
    settings = {
      client-id = "${secrets.spotify.client-id}";
      client_port = 8080;
    };
  };
}
