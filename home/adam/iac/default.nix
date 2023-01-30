{ pkgs, unstable, ... }: {
  home.packages = with pkgs; [
    vault
    pulumi-bin
    pulumictl
    terragrunt
  ] ++ (with unstable; [
    truss-cli
  ]);

  programs.zsh = {
    oh-my-zsh.plugins = [
      "terraform"
      "vault"
    ];
    zplug.plugins = [{
      name = "cda0/zsh-tfenv";
    }];
  };

}
