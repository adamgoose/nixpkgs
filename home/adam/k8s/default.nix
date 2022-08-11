{ pkgs, ... }: {
  home.packages = with pkgs; [
    k9s
    kubernetes-helm
    tilt
    kube3d
    kubectx
    teleport
  ];
}
