{ pkgs, unstable, ... }: {
  home.packages = with pkgs; [
    k9s
    tilt
    fluxcd
    kube3d
    kubectl
    kubectx
    teleport
    kubelogin-oidc
    kubernetes-helm
  ] ++ (with unstable; [
    ##
  ]);

  home.file.".config/k9s/skin.yml".source = ./files/k9s-theme.yml;
}
