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
