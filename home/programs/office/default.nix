{pkgs, ...}: {
  programs = {
    sioyek.enable = true; # A PDF viewer
  };

  home.packages = with pkgs; [
    obsidian # A powerful knowledge base
    planify # Task manager with Todoist support
    rnote # Simple drawing application to create handwritten notes
    typst # A markup-based typesetting system
  ];
}
