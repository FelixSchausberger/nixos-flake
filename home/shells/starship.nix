# {
#   lib,
#   ...
# }:
{
  programs.starship = {
    enable = true;

    # The TransientPrompt feature of Starship replaces previous prompts with a custom string.
    # This is only a valid option for the Fish shell.
    # enableTransience = true;

    # https://starship.rs/config/#prompt
    settings = {
      # add_newline = false;
      command_timeout = 1000; # Timeout for commands executed by starship (in milliseconds)

      # A minimal left prompt
      # format = lib.concatStrings [
      #   "$character"
      # ];

      git_status = {
        ahead = "⇡($count)";
        diverged = "⇕⇡($ahead_count)⇣($behind_count)";
        behind = "⇣($count)";
        modified = "!($count)";
        staged = "[++($count)](green)";
      };

      # move the rest of the prompt to the right
      # right_format = lib.concatStrings [
      #   "$all"
      # ];
    };
  };
}
