{ pkgs, inputs, unstable, ... }: {
  imports = [
    ../ide
  ];

  home.packages = with pkgs; [
    go
    air
    ctags
    cscope
    mkcert
    doppler
    gnumake
    asciinema
    termshark
    postgresql
    kotlin-language-server
    inputs.cells.hasura-cli.packages.hasura-cli
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
