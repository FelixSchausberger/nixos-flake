# FelixSchausberger/nixos

## 🗒 About

Personal configs for Home-Manager and NixOS. Using
[flakes](https://nixos.wiki/wiki/Flakes) and
[flake-parts](https://github.com/hercules-ci/flake-parts).

## 🗃️ Contents

```lang-markdown
.
├── flake.lock
├── flake.nix
├── home
│   ├── default.nix
│   ├── gui
│   │   ├── default.nix
│   │   ├── firefox
│   │   │   ├── default.nix
│   │   │   └── tabliss.css
│   │   ├── mpv.nix
│   │   ├── planify.nix
│   │   ├── spicetify.nix
│   │   ├── steam.nix
│   │   └── vscode.nix
│   ├── profiles
│   │   ├── default.nix
│   │   ├── desktop
│   │   │   └── default.nix
│   │   └── surface
│   │       └── default.nix
│   ├── scripts
│   │   ├── Cargo.lock
│   │   ├── Cargo.toml
│   │   ├── flake.lock
│   │   ├── flake.nix
│   │   ├── LICENSE
│   │   ├── README.md
│   │   ├── result
│   │   ├── src
│   │   │   └── bin
│   │   └── target
│   ├── shells
│   │   ├── bash.nix
│   │   ├── default.nix
│   │   ├── fish.nix
│   │   ├── starship.nix
│   │   └── zoxide.nix
│   ├── tui
│   │   ├── bat.nix
│   │   ├── broot.nix
│   │   ├── default.nix
│   │   ├── direnv.nix
│   │   ├── eza.nix
│   │   ├── fd.nix
│   │   ├── fzf.nix
│   │   ├── git.nix
│   │   ├── helix
│   │   │   ├── default.nix
│   │   │   └── languages.nix
│   │   ├── nix.nix
│   │   ├── rclone.nix
│   │   ├── rip.nix
│   │   ├── tealdeer.nix
│   │   ├── thefuck.nix
│   │   └── yazi
│   │       ├── default.nix
│   │       └── theme
│   │           ├── filetype.nix
│   │           ├── icons.nix
│   │           ├── manager.nix
│   │           └── status.nix
│   └── wallpapers
│       ├── appa.jpg
│       ├── solar-system.jpg
│       └── the-whale.jpg
├── hosts
│   ├── default.nix
│   ├── desktop
│   │   ├── default.nix
│   │   ├── hardware-configuration.nix
│   │   └── ssh_host_ed25519_key.pub
│   └── surface
│       ├── default.nix
│       ├── hardware-configuration.nix
│       └── ssh_host_ed25519_key.pub
├── pre-commit-hooks.nix
├── README.md
├── scripts.nix
├── secrets
│   └── secrets.json
└── system
    ├── core
    │   ├── boot.nix
    │   ├── default.nix
    │   ├── security
    │   │   ├── default.nix
    │   │   ├── sops.nix
    │   │   └── ssh.nix
    │   └── users.nix
    ├── default.nix
    ├── network.nix
    ├── nix
    │   ├── default.nix
    │   ├── nixpkgs.nix
    │   └── substituters.nix
    ├── persistence.nix
    └── programs
        ├── cosmic.nix
        ├── default.nix
        ├── development.nix
        ├── fonts.nix
        ├── home-manager.nix
        └── qmk.nix
```

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
    - `wl-paste | base64 -d > ./secrets/secret-key # bash`
  - Unlock the secrets: `git-crypt unlock ./secrets/secret-key`
- Rebuild the system: `sudo nixos-rebuild switch --flake .`
