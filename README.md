<h1 align="center">FelixSchausberger/nixos</h1>

[![built with garnix](https://img.shields.io/static/v1?label=Built%20with&message=Garnix&color=blue&style=flat&logo=nixos&link=https://garnix.io&labelColor=111212)](https://garnix.io) [![built with garnix](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2FFelixSchausberger%2Fnixos-config%3Fbranch%3Dunstable-hyprland)](https://garnix.io)

# 🗒 About

Personal configs for Home-Manager and NixOS. Using [flakes](https://nixos.wiki/wiki/Flakes) and
[flake-parts](https://github.com/hercules-ci/flake-parts).

## 🗃️ Contents

- [hosts](hosts): Host-specific configuration
- [home](home): [Home Manager](https://github.com/nix-community/home-manager)
  config
- [system](system): NixOS configurations

## 📦 Setup

1. Install NixOS with opt-in state (darling erasure), follow:
  - [NixOS Root on ZFS](https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/Root%20on%20ZFS.html#nixos-root-on-zfs) 
  - [NixOS installation with opt-in state (darling erasure)](https://gist.github.com/Quelklef/e5d0d9ea0c2777db45f0779b9996c94b) 
2. Clone this repository: `git clone https://github.com/FelixSchausberger/nixos`
3. Create a new host in `./hosts` and `.profiles`.
4. Move the `hardware-configuration.nix` to `./hosts/new_host` and create a public ssh key.
5. Decrypt the secrets file: 
  - Copy the git-crypt key from Bitwarden to the clipboard.
  - Decode the key:
    - wl-paste | base64 -d | save ./secrets/secret-key # nushell
    - wl-paste | base64 -d > ./secrets/secret-key # bash
  - Unlock the secrets: `git-crypt unlock ./secrets/secret-key`
6. Rebuild the system: `sudo nixos-rebuild switch --flake .`
