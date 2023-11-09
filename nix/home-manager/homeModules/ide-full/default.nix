{ pkgs, unstable, ... }: {
  imports = [
    ../ide
  ];

  home.packages = with pkgs; [
    go
    air
    gcc
    yarn
    ctags
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
    risor
  ]);

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
  programs.zsh.initExtra = ''
    export PATH=$HOME/go/bin:$PATH
  '';

}
