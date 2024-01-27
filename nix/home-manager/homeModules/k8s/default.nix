{ pkgs, inputs, ... }:
let
  kubeswitch = inputs.cells.kubeswitch.packages.kubeswitch;
  kubetap = inputs.cells.kubetap.packages.kubetap;
in
{
  home.packages = with pkgs; [
    k9s
    tilt
    fluxcd
    kube3d
    kubectl
    kubetap
    helmfile
    teleport
    kubeswitch
    telepresence2
    kubelogin-oidc

    (wrapHelm kubernetes-helm {
      plugins = [ kubernetes-helmPlugins.helm-diff ];
    })
  ];

  home.file.".config/k9s/skin.yml".source = ./files/k9s-theme.yml;
  home.file.".kube/switch-config.yaml".source = ./files/switch-config.yaml;

  programs.zsh.initExtraBeforeCompInit = pkgs.lib.readFile (kubeswitch + /lib/switch.sh);
}
