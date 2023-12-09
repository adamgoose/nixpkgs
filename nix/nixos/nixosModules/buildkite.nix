{ username, ... }: {

  nix.settings.trusted-users = [
    "buildkite-agent-sato48-backend"
    "buildkite-agent-sato48-frontend"
  ];

  services.buildkite-agents = {
    sato48-backend = {
      enable = true;
      name = "roxie-backend";
      tokenPath = "/etc/buildkite-agent/sato48-token";
      privateSshKeyPath = "/etc/buildkite-agent/ssh/backend.priv";
      tags = {
        queue = "sato48-backend";
      };
    };

    sato48-frontend = {
      enable = true;
      name = "roxie-festival-manager";
      tokenPath = "/etc/buildkite-agent/sato48-token";
      privateSshKeyPath = "/etc/buildkite-agent/ssh/festival-manager.priv";
      tags = {
        queue = "sato48-festival-manager";
      };
    };
  };

}
