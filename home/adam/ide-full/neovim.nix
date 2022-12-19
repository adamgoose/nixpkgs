{ pkgs, unstable, ... }: {
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

    withRuby = true;

    plugins = with pkgs.vimPlugins; [
      vim-go
      vim-nix
      vim-pug
      vim-vue
      vim-ruby
      vim-rails
      kotlin-vim

      coc-go
      coc-haxe
      coc-java
      coc-json
      coc-yaml
      # coc-volar
      coc-eslint
      coc-tsserver
    ] ++ (with unstable.vimPlugins; [
      coc-volar
    ]);
  };
}
