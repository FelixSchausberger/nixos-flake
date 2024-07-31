{inputs, ...}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  
  sops = {
      defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
      age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      secrets = {
        # "github/oauth_token" = {};
      };
    };  
}
