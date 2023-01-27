{ pkgs, unstable, ... }: {
  home.packages = with pkgs; [
    vault
    pulumi-bin
    pulumictl
    terragrunt
  ] ++ (with unstable; [
    truss-cli
  ]);

  home.shellAliases = {
    tf = "terraform";
  };

  programs.zsh.zplug = {
    plugins = [{
      name = "cda0/zsh-tfenv";
    }];
  };

}
