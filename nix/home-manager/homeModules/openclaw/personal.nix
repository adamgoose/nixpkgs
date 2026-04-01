{...}: {
  programs.openclaw.instances.personal = {
    enable = true;
    gatewayPort = 18788;
    config = {
      agents.defaults = {
        model.primary = "openrouter/anthropic/claude-sonnet-4.6";
        models."openrouter/anthropic/claude-opus-4.6" = {alias = "Claude Opus 4.6";};
        models."openrouter/anthropic/claude-sonnet-4.6" = {alias = "Claude Sonnet 4.6";};
        models."openrouter/anthropic/claude-haiku-4.6" = {alias = "Claude Haiku 4.6";};
        typingMode = "thinking";
        compaction.mode = "safeguard";
      };

      channels.telegram = {
        enabled = true;
        dmPolicy = "pairing";
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
        port = 18788;
        mode = "local";
        bind = "loopback";
        controlUi.allowedOrigins = [
          "https://openclaw-personal.bearded-ordinal.ts.net"
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

  systemd.user.services.openclaw-gateway-personal = {
    Service = {
      EnvironmentFile = [
        "/home/adam/.openclaw/credentials/openrouter"
        "/home/adam/.openclaw/credentials/telegram"
        "/home/adam/.openclaw/credentials/plaid"
      ];
    };
  };
}
