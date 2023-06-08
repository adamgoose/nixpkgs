{ pkgs, unstable, ... }: {
  home.packages = with pkgs; [
    k9s
    tilt
    fluxcd
    kube3d
    kubectl
    kubetap
    teleport
    kubeswitch
    kubelogin-oidc
    kubernetes-helm
  ] ++ (with unstable; [
    ##
  ]);

  home.file.".config/k9s/skin.yml".source = ./files/k9s-theme.yml;
  home.file.".kube/switch-config.yaml".source = ./files/switch-config.yaml;

  programs.zsh.initExtraBeforeCompInit = pkgs.lib.readFile (pkgs.kubeswitch + /lib/switch.sh);
}
