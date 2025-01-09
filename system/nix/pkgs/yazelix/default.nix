{
  writeShellScriptBin,
  sources,
  yazi,
  zellij,
  nushell,
  helix,
  ...
}:
writeShellScriptBin "yazelix" ''
  # Use the full paths to required programs
  YAZI="${yazi}/bin/yazi"
  ZELLIJ="${zellij}/bin/zellij"
  NUSHELL="${nushell}/bin/nu"
  HELIX="${helix}/bin/hx"

  # Copy yazelix configuration files if they don't exist
  YAZELIX_CONFIG_DIR="$HOME/.config/yazelix"
  if [ ! -d "$YAZELIX_CONFIG_DIR" ]; then
    mkdir -p "$YAZELIX_CONFIG_DIR"
    cp -r ${sources.yazelix}/config/* "$YAZELIX_CONFIG_DIR/"
  fi

  # Launch yazelix using zellij with the custom layout
  ZELLIJ_CONFIG_DIR="$YAZELIX_CONFIG_DIR/zellij" \
  YAZI_CONFIG_DIR="$YAZELIX_CONFIG_DIR/yazi" \
  "$ZELLIJ" --layout "$YAZELIX_CONFIG_DIR/zellij/layouts/yazelix.kdl"
''
