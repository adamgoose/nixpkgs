{ pkgs, unstable, ... }: {
  imports = [
    ../ide
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    # go_1_18
    clang
    ctags
    cscope
    rnix-lsp
    postgresql
    kotlin-language-server
  ] ++ (with unstable; [
    go_1_19
  ]);
}
