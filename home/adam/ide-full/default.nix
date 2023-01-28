{ pkgs, unstable, ... }: {
  imports = [
    ../ide
    # ./neovim.nix
  ];

  home.packages = with pkgs; [
    go
    gcc
    ctags
    cscope
    doppler
    gnumake
    postgresql
    kotlin-language-server
  ] ++ (with unstable; [
    ## 
  ]);

  programs.zsh.initExtra = ''
    export PATH=$HOME/go/bin:$PATH
  '';

}
