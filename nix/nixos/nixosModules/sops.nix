{
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    age
    sops
    passage
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = inputs.self + "/secrets.yaml";
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };

  sops.secrets = {
    "protonmail-bridge/ageKey" = {
      owner = username;
      path = "/home/${username}/.passage/identities";
    };
  };
}
