{
  pkgs,
  inputs,
  unstable,
  ...
}: {
  imports = [
    ../ide
  ];

  home.packages = with pkgs;
    [
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
      unstable.bun
      kotlin-language-server
    ]
    ++ (with unstable; [
      risor
    ]);

  programs.zsh.oh-my-zsh.plugins = [
    "golang"
  ];
  programs.zsh.initContent = ''
    export PATH=$HOME/go/bin:$PATH
  '';
}
