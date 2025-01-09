{
  lib,
  rustPlatform,
  pkg-config,
  udisks2,
  dbus,
  sources,
  llvmPackages,
  linuxHeaders,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "mmtui";
  version = "0.1.0"; # Update as needed

  src = sources.mmtui;

  cargoLock = {
    lockFile = "${sources.mmtui}/Cargo.lock";
  };

  LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";
  BINDGEN_EXTRA_CLANG_ARGS = "-I${linuxHeaders}/include";

  nativeBuildInputs = [pkg-config llvmPackages.libclang];
  buildInputs = [udisks2 dbus linuxHeaders];

  meta = with lib; {
    description = "Mount manager TUI";
    homepage = "https://github.com/SL-RU/mmtui";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
