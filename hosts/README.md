# Hosts config

| Name      | Description                                               |
| --------- | --------------------------------------------------------- |
| `desktop` | Main machine                                              |
| `surface` | Surface Pro 5, retired and rarely used                    |

All the hosts have a shared config in `modules/core.nix`. Host specific configs
are stored inside the specific host dir. Each host imports its own modules
inside `default.nix`.
