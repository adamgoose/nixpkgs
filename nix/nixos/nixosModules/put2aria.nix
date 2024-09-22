{
  username,
  config,
  ...
}: {
  sops.secrets = {
    "put2aria/putio/oauthToken" = {
      owner = username;
    };
    "put2aria/aria2/rpcSecret" = {
      owner = username;
    };
  };

  services.put2aria = {
    enable = true;
    user = username;
    listen = ":8882";
    putio = {
      oauthTokenFile = config.sops.secrets."put2aria/putio/oauthToken".path;
    };
    aria2 = {
      rpcUrl = "ws://mildred:6800/jsonrpc";
      rpcSecretFile = config.sops.secrets."put2aria/aria2/rpcSecret".path;
    };
  };
}
