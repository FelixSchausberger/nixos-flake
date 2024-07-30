# FelixSchausberger/nixos

## 🗒 About

Personal configs for Home-Manager and NixOS. Using
[flakes](https://nixos.wiki/wiki/Flakes) and
[flake-parts](https://github.com/hercules-ci/flake-parts).

## 🗃️ Contents

- [hosts](hosts): Host-specific configuration
- [home](home): [Home Manager](https://github.com/nix-community/home-manager)
  config
- [system](system): NixOS configurations

## 📦 Setup

- Install NixOS with opt-in state (darling erasure), follow:
  - [NixOS Root on ZFS](https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/Root%20on%20ZFS.html#nixos-root-on-zfs)
  - [NixOS installation with opt-in state (darling erasure)](https://gist.github.com/Quelklef/e5d0d9ea0c2777db45f0779b9996c94b)
- Clone this repository: `git clone https://github.com/FelixSchausberger/nixos`
- Create a new host in `./hosts` and `.profiles`.
- Move the `hardware-configuration.nix` to `./hosts/new_host` and create a
public ssh key.
- [Handle secrets in nixos](https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview):
  - Copy the git-crypt key from Bitwarden to the clipboard and decode the key:
    - `wl-paste | base64 -d | save ./secrets/secret-key # nushell`
    - `wl-paste | base64 -d > ./secrets/secret-key # bash`
  - Unlock the secrets: `git-crypt unlock ./secrets/secret-key`
6. Rebuild the system: `sudo nixos-rebuild switch --flake .`
