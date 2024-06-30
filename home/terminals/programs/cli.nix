{pkgs, ...}:
{
  home.packages = with pkgs; [
    fd # A simple, fast and user-friendly alternative to find
    ouch # A CLI for easily compressing and decompressing files and directories
    procs # A modern replacement for ps
    rm-improved # Replacement for rm
    ripgrep-all # Ripgrep, but also search in PDFs, E-Books, Office documents, ...
  ];

  programs = {
    bottom.enable = true; # A cross-platform graphical process/system monitor
  };
}
