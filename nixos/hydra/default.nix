{ ... }: {

  services.hydra = {
    enable = true;
    hydraURL = "http://roxie:3000";
    notificationSender = "adam@enge.me";
    buildMachinesFiles = [ ];
    useSubstitutes = true;
    extraConfig = ''
      <dynamicruncommand>
        enable = 1
      </dynamicruncommand>
    '';
    extraEnv = {
      GHCR_CREDENTIALS = "adamgoose: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";
    };
  };

  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };

}
