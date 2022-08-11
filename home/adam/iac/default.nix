{ pkgs, ... }: {
  home.packages = with pkgs; [
    vault
    tfswitch
    pulumi-bin
    terragrunt
    truss-cli
  ];
}
