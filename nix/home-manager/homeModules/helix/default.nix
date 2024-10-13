{
  pkgs,
  unstable,
  ...
}: {
  programs.helix = {
    enable = true;
    package = unstable.helix;
    extraPackages = with pkgs; [
      nil
      delve
      gopls
      deadnix
      alejandra
      terraform-ls
      lua-language-server
      yaml-language-server
      unstable.vue-language-server
      nodePackages.typescript-language-server
    ];
    settings = {
      theme = "catppuccin_macchiato_custom";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        color-modes = true;
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
        };
        indent-guides = {
          render = true;
          skip-levels = 1;
          character = "▏";
        };
        lsp = {
          display-messages = true;
        };
        whitespace = {
          render = {
            tab = "all";
          };
        };
      };
    };
    languages = {
      language-server = {
        statix = {
          command = "statix check";
          args = ["check" "--stdin" "--format=json"];
        };
        deadnix.command = "deadnix";
        typescript-language-server.config = {
          plugins = [
            {
              name = "@vue/typescript-plugin";
              location = "./node_modules";
              languages = ["vue"];
            }
          ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "alejandra";
          };
          language-servers = ["nil" "statix" "deadnix"];
        }
        {
          name = "vue";
          language-servers = ["typescript-language-server" "vuels"];
        }
      ];
    };
    themes = {
      catppuccin_macchiato_custom = {
        inherits = "catppuccin_macchiato";
        "ui.background" = {
          fg = "text";
        };
        "diagnostic.unnecessary" = {
          underline = {
            color = "surface2";
            style = "curl";
          };
        };
      };
    };
  };
}
