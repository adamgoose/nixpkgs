{ pkgs, unstable, ... }: {
  imports = [
    ../ide
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    gnumake
    clang
    ctags
    cscope
    rnix-lsp
    postgresql
    kotlin-language-server
  ] ++ (with unstable; [
    go_1_19
    doppler
  ]);
}
