{pkgs, ...}: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = "/etc/cloudflare/api-token-file";
    domains = [
      "enge.me"
      "home.enge.me"
    ];
  };
}
