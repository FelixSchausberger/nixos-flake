{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    age # Modern encryption tool with small explicit keys
    ssh-to-age # Convert ssh private keys in ed25519 format to age keys
    sops # Simple and flexible tool for managing secrets
  ];

  sops = {
    age.sshKeyPaths = ["/home/${inputs.self.lib.user}/.ssh/id_ed25519"];
    # age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    defaultSopsFile = "${inputs.self}/secrets/secrets.json";

    secrets = {
      "fesch/password" = {
        owner = inputs.self.lib.user;
        group = "users";
        mode = "0400";
        neededForUsers = true;
      };
      "fesch/id_ed25519" = {
        owner = inputs.self.lib.user;
        group = "users";
        mode = "0400";
        neededForUsers = true;
      };
      "github/token" = {
        owner = inputs.self.lib.user;
        mode = "0400";
        path = "${config.sops.defaultSymlinkPath}/github/token";
      };
      "rclone/client-id" = {
        owner = inputs.self.lib.user;
        mode = "0400";
      };
      "rclone/client-secret" = {
        owner = inputs.self.lib.user;
        mode = "0400";
      };
      "wifi/pretty-fly-for-a-wifi" = {
        owner = inputs.self.lib.user;
        mode = "0400";
      };
      "wifi/hochbau-talstation" = {
        owner = inputs.self.lib.user;
        mode = "0400";
      };
    };
  };
}
