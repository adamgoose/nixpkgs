{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    libnfs
    nfs-utils
  ];

  services.k3s = {
    enable = true;
    extraFlags = toString [
      "--disable traefik"
      "--node-label 'svc-lb.tailscale.iptables.sh/deploy=true'"
      "--kube-apiserver-arg 'oidc-issuer-url=https://authentik.enge.me/application/o/k8s-on-nixos/'"
      "--kube-apiserver-arg 'oidc-client-id=f95b622267c49c8cb77309afef936830db1bc035'"
      "--kube-apiserver-arg 'oidc-username-claim=email'"
      "--kube-apiserver-arg 'oidc-groups-claim=groups'"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 49199 51826 21064 32400 ];
  networking.firewall.interfaces.cni0.allowedTCPPortRanges = [{from = 1; to = 65535;}];
  networking.firewall.interfaces.tailscale0.allowedTCPPortRanges = [{from = 1; to = 65535;}];

}
