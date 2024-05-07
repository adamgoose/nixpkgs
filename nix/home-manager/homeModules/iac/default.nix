{ pkgs, inputs, ... }:
let
  inherit (inputs.cells) truss-cli;
in
{

  home.packages = with pkgs; [
    vault
    pulumi-bin
    pulumictl
    terragrunt
  ];

  home.sessionVariables = {
    PULUMI_IGNORE_AMBIENT_PLUGIN = "true";
  };

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
