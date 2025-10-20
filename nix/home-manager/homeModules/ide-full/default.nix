{pkgs, ...}: {
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
  ];

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
  programs.zsh.initContent = ''
    export PATH=$HOME/go/bin:$PATH
  '';
}
