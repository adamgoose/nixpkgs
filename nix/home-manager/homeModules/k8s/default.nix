{ pkgs
, unstable
, inputs
, ...
}:
let
  kubeswitch = inputs.cells.kubeswitch.packages.kubeswitch;
  kubetap = inputs.cells.kubetap.packages.kubetap;

  yamlFormat = pkgs.formats.yaml { };
in
{
  home.packages = with pkgs; [
    tilt
    fluxcd
    kube3d
    kubectl
    kubetap
    helmfile
    kubeswitch
    unstable.k9s
    telepresence2
    kubelogin-oidc

    (wrapHelm kubernetes-helm {
      plugins = [ kubernetes-helmPlugins.helm-diff ];
    })
  ];

  home.file.".kube/switch-config.yaml".source = ./files/switch-config.yaml;

  xdg.configFile."k9s/skins/catppuccin.yaml".source = ./files/k9s-theme.yml;
  xdg.configFile."k9s/config.yaml".source = yamlFormat.generate "k9s-config" {
    k9s = {
      ui = {
        enableMouse = true;
        skin = "catppuccin";
      };
    };
  };

  programs.zsh.initExtraBeforeCompInit = pkgs.lib.readFile (kubeswitch + /lib/switch.sh);
}
