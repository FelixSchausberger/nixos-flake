# System

Common configuration files shared across hosts.

| Name          | Description                                            |
| ------------- | ------------------------------------------------------ |
| `default.nix` | Flake-parts module, entry point                        |
| core          | Core configurations, including boot, security, users   |
| hardware      | Controls hardware, such as Bluetooth, video cards, etc |
| `network.nix` | Network-related software configuration                 |
| nix           | Nix-related options                                    |
| programs      | `programs.*` configuration                             |
