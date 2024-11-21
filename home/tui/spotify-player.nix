# {pkgs, ...}:
{
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
  };
}
