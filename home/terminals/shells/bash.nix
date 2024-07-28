{
  programs.bash = {
    enable = true;

    bashrcExtra = ''
      eval "$(direnv hook bash)"
    '';
  };
}
