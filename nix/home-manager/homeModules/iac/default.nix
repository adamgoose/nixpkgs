{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    vault
    (pulumi.overrideAttrs {
      doCheck = false;
    })
    pulumiPackages.pulumi-language-go
    pulumiPackages.pulumi-language-nodejs
  ];

  home.sessionVariables = {
    PULUMI_IGNORE_AMBIENT_PLUGINS = "true";
  };

  programs.zsh = {
    oh-my-zsh.plugins = [
      "terraform"
      "vault"
    ];
    zplug.plugins = [
      {
        name = "cda0/zsh-tfenv";
      }
    ];
  };
}
