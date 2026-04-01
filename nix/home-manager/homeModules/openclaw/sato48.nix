{...}: {
  programs.openclaw.instances.sato48 = {
    enable = true;
    config = {
      agents.defaults = {
        model.primary = "openrouter/openai/gpt-5.4";
        models."openrouter/openai/gpt-5.4" = {alias = "GPT 5.4";};
        models."openrouter/openai/gpt-5.4-mini" = {alias = "GPT 5.4 Mini";};
        models."openrouter/openai/gpt-5.4-nano" = {alias = "GPT 5.4 Nano";};
        models."openrouter/anthropic/claude-opus-4.6" = {alias = "Claude Opus 4.6";};
        models."openrouter/anthropic/claude-sonnet-4.6" = {alias = "Claude Sonnet 4.6";};
        models."openrouter/anthropic/claude-haiku-4.6" = {alias = "Claude Haiku 4.6";};
        typingMode = "thinking";
        compaction.mode = "safeguard";
      };

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

      discovery.mdns.mode = "off";
      session.dmScope = "per-channel-peer";
      commands = {
        native = "auto";
        nativeSkills = "auto";
        restart = true;
        ownerDisplay = "raw";
      };
      tools = {
        profile = "coding";
      };
      gateway = {
        port = 18789;
        mode = "local";
        bind = "loopback";
        controlUi.allowedOrigins = [
          "https://openclaw-sato48.bearded-ordinal.ts.net"
        ];
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
    };
  };

  systemd.user.services.openclaw-gateway-sato48 = {
    Service = {
      EnvironmentFile = [
        "/home/adam/.openclaw/credentials/sato48"
      ];
    };
  };
}
