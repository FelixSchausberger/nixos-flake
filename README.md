# 🗒 About

Personal configs for Home-Manager and NixOS. Using \\
[flakes](https://nixos.wiki/wiki/Flakes) and
[flake-parts](https://github.com/hercules-ci/flake-parts).

## 🗃️ Contents

- [hosts](hosts): Host-specific configuration
- [home](home): [Home Manager](https://github.com/nix-community/home-manager)
  config
- [system](system): NixOS configurations

## 📦 Setup

1. Install NixOS with opt-in state (darling erasure), follow:
  1.1. [NixOS Root on ZFS](https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/Root%20on%20ZFS.html#nixos-root-on-zfs)
  1.2. [NixOS installation with opt-in state (darling erasure)](https://gist.github.com/Quelklef/e5d0d9ea0c2777db45f0779b9996c94b)
2. Clone this repository: `git clone https://github.com/FelixSchausberger/nixos`
3. Create a new host in `./hosts` and `.profiles`.
4. Move the `hardware-configuration.nix` to `./hosts/new_host` and create a \\
public ssh key.
5. Secrets: [How to handle secrets in nixos](https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview):
  5.1. Copy the git-crypt key from Bitwarden to the clipboard.
  5.2. Decode the key:
    5.2.1. wl-paste | base64 -d | save ./secrets/secret-key # nushell
    5.2.2. wl-paste | base64 -d > ./secrets/secret-key # bash
  5.3. Unlock the secrets: `git-crypt unlock ./secrets/secret-key`
6. Rebuild the system: `sudo nixos-rebuild switch --flake .`
