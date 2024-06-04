{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    vault
    (pulumi.overrideAttrs {
      doCheck = false;
    })
  ];

  home.sessionVariables = {
    PULUMI_IGNORE_AMBIENT_PLUGIN = "true";
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
