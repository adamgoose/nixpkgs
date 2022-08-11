{ pkgs, ... }: {
  imports = [
    ../ide
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    go_1_18
    rnix-lsp
    postgresql
    kotlin-language-server
  ];
}
