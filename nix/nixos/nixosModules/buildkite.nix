{config, ...}: {
  nix.settings.trusted-users = [
    config.users.users.buildkite-agent-sato48-backend.name
    config.users.users.buildkite-agent-sato48-frontend.name
    config.users.users.buildkite-agent-sato48-email.name
  ];

  sops.secrets = {
    "buildkite/agents/sato48/token" = {
      mode = "0440";
      group = config.users.groups.keys.name;
    };
    "buildkite/agents/sato48/ssh/backend" = {
      owner = config.users.users.buildkite-agent-sato48-backend.name;
    };
    "buildkite/agents/sato48/ssh/frontend" = {
      owner = config.users.users.buildkite-agent-sato48-frontend.name;
    };
    "buildkite/agents/sato48/ssh/email" = {
      owner = config.users.users.buildkite-agent-sato48-email.name;
    };
    "buildkite/agents/sato48/sopsKey" = {
      mode = "0444";
    };
  };

  services.buildkite-agents = let
    environment = ''
      echo '--- :house_with_garden: Setting up the environment'
      export SOPS_AGE_KEY_FILE=${config.sops.secrets."buildkite/agents/sato48/sopsKey".path}
    '';
  in {
    default = {
      enable = true;
      name = "totoro";
      tokenPath = config.sops.secrets."buildkite/agents/sato48/token".path;
    };

    sato48-backend = {
      enable = true;
      name = "totoro-backend";
      tokenPath = config.sops.secrets."buildkite/agents/sato48/token".path;
      privateSshKeyPath = config.sops.secrets."buildkite/agents/sato48/ssh/backend".path;
      tags = {
        queue = "sato48-backend";
      };
      hooks = {
        inherit environment;
      };
    };

    sato48-frontend = {
      enable = true;
      name = "totoro-festival-manager";
      tokenPath = config.sops.secrets."buildkite/agents/sato48/token".path;
      privateSshKeyPath = config.sops.secrets."buildkite/agents/sato48/ssh/frontend".path;
      tags = {
        queue = "sato48-festival-manager";
      };
      hooks = {
        inherit environment;
      };
    };

    sato48-email = {
      enable = true;
      name = "totoro-email";
      tokenPath = config.sops.secrets."buildkite/agents/sato48/token".path;
      privateSshKeyPath = config.sops.secrets."buildkite/agents/sato48/ssh/email".path;
      tags = {
        queue = "sato48-email";
      };
      hooks = {
        inherit environment;
      };
    };
  };
}
