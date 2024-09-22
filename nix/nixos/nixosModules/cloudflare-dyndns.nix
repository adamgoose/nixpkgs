{config, ...}: {
  sops.secrets = {
    "cloudflare/apiToken" = {};
  };

  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.sops.secrets."cloudflare/apiToken".path;
    domains = [
      "enge.me"
      "home.enge.me"
    ];
  };
}
