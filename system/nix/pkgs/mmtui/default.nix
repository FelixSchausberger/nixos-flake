{
  lib,
  rustPlatform,
  pkg-config,
  udisks2,
  dbus,
  llvmPackages,
  linuxHeaders,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "mmtui";
  version = "master";

  src = fetchFromGitHub {
    owner = "SL-RU";
    repo = "mmtui";
    rev = "master";
    sha256 = "sha256-ZJDmW1Z9W6v5LGCpuJpviKTcQ1CWqY9gPB12W82Tidw=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
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
