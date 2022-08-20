{ pkgs, ... }: {
  home.packages = with pkgs; [
    k9s
    tilt
    fluxcd
    kube3d
    kubectl
    kubectx
    teleport
    kubernetes-helm
  ];
}
