{
  pkgs,
  unstable,
  inputs,
  ...
}: let
  kubeswitch = inputs.cells.kubeswitch.packages.kubeswitch;
  kubetap = inputs.cells.kubetap.packages.kubetap;
in {
  home.packages = with pkgs; [
    tilt
    fluxcd
    kube3d
    kubectl
    kubetap
    helmfile
    kubeswitch
    telepresence2
    kubelogin-oidc

    (wrapHelm kubernetes-helm {
      plugins = [kubernetes-helmPlugins.helm-diff];
    })
  ];

  programs.k9s = {
    enable = true;
    package = unstable.k9s;
    settings = {
      k9s = {
        ui = {
          enableMouse = true;
        };
      };
    };
  };

  home.file.".kube/switch-config.yaml".source = ./files/switch-config.yaml;
  programs.zsh.initContent = pkgs.lib.mkOrder 550 (pkgs.lib.readFile (kubeswitch + /lib/switch.sh));
}
