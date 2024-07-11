let
  defaultTerminal = "rio";
in {
  imports = [
    # ./foot.nix # A fast, lightweight and minimalistic Wayland terminal emulator
    ./rio.nix # A hardware-accelerated GPU terminal emulator powered by WebGPU
    ./wezterm.nix # GPU-accelerated cross-platform terminal emulator and multiplexer
  ];

  # Export the variable so it can be used in other files
  _module.args.defaultTerminal = defaultTerminal;
}
