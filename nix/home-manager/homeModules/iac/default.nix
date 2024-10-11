{pkgs, ...}: {
  home.packages = with pkgs; [
    vault-bin
    pulumi-bin
  ];

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
