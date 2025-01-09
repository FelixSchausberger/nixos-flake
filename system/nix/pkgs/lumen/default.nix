{
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  sources,
}:
rustPlatform.buildRustPackage {
  pname = "lumen";
  version = "0.1.0";

  src = sources.lumen;

  cargoLock = {
    lockFile = "${sources.lumen}/Cargo.lock";
  };

  nativeBuildInputs = [pkg-config openssl.dev];
  buildInputs = [openssl];

  meta = with lib; {
    description = "A blazingly fast CLI tool to set backlight brightness";
    homepage = "https://github.com/jnsahaj/lumen";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
