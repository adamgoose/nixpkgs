{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit
    (lib)
    concatMapStringsSep
    generators
    ;

  settingsFormatIni = pkgs.formats.ini {
    listToValue = concatMapStringsSep " " (generators.mkValueStringDefault {});
    mkKeyValue = generators.mkKeyValueDefault {
      mkValueString = v:
        if v == null
        then ""
        else generators.mkValueStringDefault {} v;
    } "=";
  };
  configFile = settingsFormatIni.generate "typesense.ini" {
    server = {
      api-address = "0.0.0.0";
      data-dir = "/var/lib/typesense";
      enable-cors = true;
      thread-pool-size = 192;
      num-collections-parallel-load = 96;
    };
  };
in {
  sops.secrets = {
    "typesense/api-key" = {
      mode = "0444";
    };
  };

  # services.typesense = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       api-address = "0.0.0.0";
  #       enableCors = true;
  #     };
  #   };
  #   apiKeyFile = config.sops.secrets."typesense/api-key".path;
  # };

  systemd.services.typesense = {
    description = "Typesense search engine";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    script = ''
      export TYPESENSE_API_KEY=$(cat ${config.sops.secrets."typesense/api-key".path})
      exec ${pkgs.typesense}/bin/typesense-server --config ${configFile}
    '';

    serviceConfig = {
      Restart = "on-failure";
      # DynamicUser = true;
      User = "adam";
      Group = "root";

      StateDirectory = "typesense";
      StateDirectoryMode = "0750";

      # Hardening
      # CapabilityBoundingSet = "";
      # LockPersonality = true;
      # # MemoryDenyWriteExecute = true; needed since 0.25.1
      # NoNewPrivileges = true;
      # PrivateUsers = true;
      # PrivateTmp = true;
      # PrivateDevices = true;
      # PrivateMounts = true;
      # ProtectClock = true;
      # ProtectControlGroups = true;
      # ProtectHome = true;
      # ProtectHostname = true;
      # ProtectKernelLogs = true;
      # ProtectKernelModules = true;
      # ProtectKernelTunables = true;
      # ProtectProc = "invisible";
      # ProcSubset = "pid";
      # ProtectSystem = "full";
      # RemoveIPC = true;
      # RestrictAddressFamilies = [
      #   "AF_INET"
      #   "AF_INET6"
      #   "AF_UNIX"
      # ];
      # RestrictNamespaces = true;
      # RestrictRealtime = true;
      # RestrictSUIDSGID = true;
      # SystemCallArchitectures = "native";
      # SystemCallFilter = [
      #   "@system-service"
      #   "~@privileged"
      # ];
      # UMask = "0077";
    };
  };
}
