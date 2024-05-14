{...}: {
  services.hydra = {
    enable = true;
    hydraURL = "http://roxie:3000";
    notificationSender = "adam@enge.me";
    buildMachinesFiles = [];
    useSubstitutes = true;
    extraConfig = ''
      <dynamicruncommand>
        enable = 1
      </dynamicruncommand>
    '';
    extraEnv = {
      GHCR_CREDENTIALS = "adamgoose:XXX";
    };
  };

  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };
}
