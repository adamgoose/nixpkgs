{ ... }: {

  # Enable Tailscale
  services.tailscale.enable = true;

  # Configure DNS
  networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  networking.search = [ "enge.me.beta.tailscale.net" ];

  # Configure Firewall
  networking.firewall = {
    checkReversePath = "loose";
    interfaces.tailscale0 = {
      allowedTCPPortRanges = [{ from = 1; to = 65535; }];
      allowedUDPPortRanges = [{ from = 1; to = 65535; }];
    };
  };

}
