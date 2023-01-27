{ pkgs, unstable, ... }: {
  imports = [
    ../ide
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    go
    gcc
    ctags
    cscope
    doppler
    gnumake
    rnix-lsp
    postgresql
    kotlin-language-server
  ] ++ (with unstable; [
    ## 
  ]);
}
