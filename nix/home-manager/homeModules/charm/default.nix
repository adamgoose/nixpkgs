{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.charm;
in
{

  options = {
    services.charm = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable the Charm service
        '';
      };

      host = mkOption {
        default = "localhost";
        description = ''
          The hostname to advertise for the Charm server
        '';
      };

      bind = mkOption {
        default = "0.0.0.0";
        description = ''
          The address to bind the Charm server to
        '';
      };

      tls = {
        enable = mkOption {
          default = false;
          description = ''
            Whether to generate TLS Certificates for Charm
          '';
        };
      };
    };
  };

  config = mkMerge [
    {
      home.packages = with pkgs; [ charm skate ];
    }
    (mkIf cfg.enable {
      # home.packages = with pkgs; [ charm skate ];

      home.sessionVariables = {
        CHARM_HOST = cfg.host;
        CHARM_DATA_DIR = "${config.xdg.dataHome}/charm-client";
      };

      launchd.agents.charm = {
        enable = true;
        config = {
          ProgramArguments = [ "${pkgs.charm}/bin/charm" "serve" ];
          EnvironmentVariables = {
            CHARM_SERVER_HOST = cfg.host;
            CHARM_SERVER_BIND_ADDRESS = cfg.bind;
            CHARM_SERVER_DATA_DIR = "${config.xdg.dataHome}/charm-server";
          };
          KeepAlive = {
            Crashed = true;
            SuccessfulExit = false;
          };
          ProcessType = "Background";
          StandardErrorPath = "${config.xdg.dataHome}/charm-server/log/charm.stderr.log";
          StandardOutPath = "${config.xdg.dataHome}/charm-server/log/charm.stdout.log";
        };
      };
    })
    (mkIf cfg.tls.enable {
      launchd.agents.charm.config.EnvironmentVariables = {
        CHARM_SERVER_TLS_KEY_FILE = "${config.xdg.dataHome}/charm-server/tls/charm.key";
        CHARM_SERVER_TLS_CERT_FILE = "${config.xdg.dataHome}/charm-server/tls/charm.crt";
      };

      home.activation = {
        charm = hm.dag.entryAfter [ "writeBoundary" ] ''
          mkdir -p ${config.xdg.dataHome}/charm-server/tls
          ${pkgs.mkcert}/bin/mkcert \
            -cert-file ${config.xdg.dataHome}/charm-server/tls/charm.crt \
            -key-file ${config.xdg.dataHome}/charm-server/tls/charm.key \
            ${cfg.host}
        '';
      };
    })
  ];

}
