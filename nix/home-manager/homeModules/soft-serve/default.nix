{ pkgs, unstable, lib, config, ... }:
let
  l = lib // builtins;
in
{

  home.packages = [ unstable.soft-serve ];

  systemd.user.services = {
    soft-serve = {
      Unit = {
        Description = "Soft Serve";
        After = [ "network.target" ];
      };

      Service = {
        Environment = [
          "SOFT_SERVE_DATA_PATH=${config.xdg.dataHome}/soft-serve"
          "SOFT_SERVE_INITIAL_ADMIN_KEYS=/home/adam/.ssh/id_ed25519.pub"
        ];
        ExecStart = "${unstable.soft-serve}/bin/soft serve";
        Restart = "on-failure";
        SuccessExitStatus = [ 3 4 ];
        RestartForceExitStatus = [ 3 4 ];

        # Sandboxing.
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        NoNewPrivileges = true;
        PrivateUsers = true;
        RestrictNamespaces = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = "@system-service";
      };

      Install = { WantedBy = [ "default.target" ]; };
    };
  };

}
