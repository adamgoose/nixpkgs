{ pkgs, unstable, ... }: {
  home.packages = with pkgs; [
    tilt
    fluxcd
    kube3d
    kubectl
    kubectx
    teleport
    kubelogin-oidc
    kubernetes-helm
  ] ++ (with unstable; [
    k9s
  ]);
}
