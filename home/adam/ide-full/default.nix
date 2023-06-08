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
    mkcert
    doppler
    gnumake
    asciinema
    hasura-cli
    postgresql
    kotlin-language-server
  ] ++ (with unstable; [
    ## 
  ]);

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
  programs.zsh.initExtra = ''
    export PATH=$HOME/go/bin:$PATH
  '';

}
