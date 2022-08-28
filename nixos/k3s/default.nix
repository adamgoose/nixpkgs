{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    libnfs
    nfs-utils
  ];

  services.k3s = {
    enable = true;
    extraFlags = "--disable traefik --node-label 'svc-lb.tailscale.iptables.sh/deploy=true'";
  };

  networking.firewall.allowedTCPPorts = [ 80 443 49199 51826 21064 ];
  networking.firewall.interfaces.cni0.allowedTCPPortRanges = [{from = 1; to = 65535;}];
  networking.firewall.interfaces.tailscale0.allowedTCPPortRanges = [{from = 1; to = 65535;}];

}
