{ pkgs, ... }: {
  home.packages = with pkgs; [
    k9s
    tilt
    kube3d
    kubectl
    kubectx
    teleport
    kubernetes-helm
  ];
}
