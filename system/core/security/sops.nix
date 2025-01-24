{
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
  ];

  sops = {
    defaultSopsFile = "${inputs.self}/secrets/secrets.json";
    # age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    # secrets = {
    #   "github/oauth_token" = {};
    # };
  };
}
