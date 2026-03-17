{
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.nix-openclaw.homeManagerModules.openclaw
  ];

  programs.openclaw = {
    enable = true;
    exposePluginPackages = false;

    config = {
      discovery.mdns.mode = "off";

      agents.defaults = {
        model.primary = "openai/gpt-5.4";
        models."openai/gpt-5.4" = {alias = "GPT 5.4";};
        models."openai/gpt-5.4-mini" = {alias = "GPT 5.4 Mini";};
        models."openai/gpt-5.4-nano" = {alias = "GPT 5.4 Nano";};
        typingMode = "thinking";
        compaction.mode = "safeguard";
      };

      agents.list = [
        {
          id = "sato48";
          workspace = "/home/${username}/.openclaw/workspace-sato48";
        }
      ];

      commands = {
        native = "auto";
        nativeSkills = "auto";
        restart = true;
        ownerDisplay = "raw";
      };

      session.dmScope = "per-channel-peer";

      channels.slack = {
        enabled = true;
        mode = "socket";
        commands.native = true;
        replyToMode = "all";
        capabilities = {
          interactiveReplies = true;
        };
        channels = {
          # 🔒claw-chat
          C0APN0CHJN8 = {
            allow = true;
            requireMention = false;
            allowBots = false;
          };
        };
      };

      gateway = {
        port = 18789;
        mode = "local";
        bind = "loopback";
        controlUi.allowedOrigins = [
          "https://totoro"
          "https://totoro.bearded-ordinal.ts.net"
        ];
        auth = {
          allowTailscale = true;
        };
        tailscale = {
          mode = "serve";
          resetOnExit = false;
        };
        nodes.denyCommands = [
          "camera.snap"
          "camera.clip"
          "screen.record"
          "contacts.add"
          "calendar.add"
          "reminders.add"
          "sms.send"
        ];
      };

      tools = {
        profile = "coding";
      };
    };
  };

  systemd.user.services.openclaw-gateway = {
    Service = {
      EnvironmentFile = [
        "/home/adam/.openclaw/credentials/openai"
        "/home/adam/.openclaw/credentials/slack"
      ];
    };
  };
}
