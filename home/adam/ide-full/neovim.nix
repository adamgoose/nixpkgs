{ pkgs, ... }: {
  programs.neovim = {
    coc.settings = {
      languageserver = {
        nix = {
          command = "rnix-lsp";
          filetypes = [ "nix" ];
        };
        kotlin = {
          command = "kotlin-language-server";
          filetypes = [ "kotlin" ];
          "trace.server" = "messages";
          settings = {
            kotlin = {
              compiler = {
                jvm = {
                  target = "17";
                };
              };
            };
          };
        };
      };
    };

    plugins = with pkgs.vimPlugins; [
      vim-go
      coc-go
      coc-haxe
      coc-java
      kotlin-vim
      vim-nix
    ];
  };
}
