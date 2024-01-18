{ username, ... }: {

  nix.settings.trusted-users = [
    "buildkite-agent-sato48-backend"
    "buildkite-agent-sato48-frontend"
  ];

  services.buildkite-agents = {
    default = {
      enable = true;
      name = "totoro";
      tokenPath = "/etc/buildkite-agent/sato48-token";
    };

    sato48-backend = {
      enable = true;
      name = "totoro-backend";
      tokenPath = "/etc/buildkite-agent/sato48-token";
      privateSshKeyPath = "/etc/buildkite-agent/ssh/backend.priv";
      tags = {
        queue = "sato48-backend";
      };
    };

    sato48-frontend = {
      enable = true;
      name = "totoro-festival-manager";
      tokenPath = "/etc/buildkite-agent/sato48-token";
      privateSshKeyPath = "/etc/buildkite-agent/ssh/festival-manager.priv";
      tags = {
        queue = "sato48-festival-manager";
      };
    };
  };

}
