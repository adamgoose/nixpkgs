{ pkgs, unstable, ... }: {
  imports = [
    ../ide
  ];

  home.packages = with pkgs; [
    go
    gcc
    yarn
    ctags
    risor
    cscope
    mkcert
    doppler
    gnumake
    asciinema
    termshark
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
