{
  lib,
  rustPlatform,
  sources,
}:
rustPlatform.buildRustPackage rec {
  pname = "cosmic-ext-alternative-startup";
  version = "0.1.0";

  src = sources.cosmic-ext-alternative-startup;

  cargoLock = {
    lockFile = "${sources.cosmic-ext-alternative-startup}/Cargo.lock";
  };

  meta = with lib; {
    description = "Alternative startup script for Cosmic desktop extensions";
    homepage = "https://github.com/Drakulix/cosmic-ext-alternative-startup";
    license = licenses.mit;
    maintainers = with maintainers; [drakulix];
  };
}
