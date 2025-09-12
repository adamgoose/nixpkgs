{
  pkgs,
  inputs,
  unstable,
  ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.helix;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nil
      delve
      gopls
      kdlfmt
      deadnix
      alejandra
      terraform-ls
      lua-language-server
      yaml-language-server
      tailwindcss-language-server
      unstable.vue-language-server
      unstable.nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.vscode-json-languageserver
    ];
    settings = {
      editor = {
        bufferline = "multiple";
        cursorline = true;
        color-modes = true;
        line-number = "relative";
        rulers = [80 120];
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
          display-inlay-hints = true;
          display-progress-messages = true;
        };
        whitespace = {
          render = {
            tab = "all";
          };
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "error";
        };
      };
    };
    languages = {
      language-server = {
        vscode-json-language-server.command = "vscode-json-languageserver";
        statix = {
          command = "statix check";
          args = ["check" "--stdin" "--format=json"];
        };
        deadnix.command = "deadnix";
        tailwindcss = {
          command = "tailwindcss-language-server";
          args = ["--stdio"];
          config = {
            userLanguages = {tsx = "tsx";};
          };
        };
        typescript-language-server.config = {
          plugins = [
            {
              name = "@vue/typescript-plugin";
              location = "./node_modules";
              languages = ["vue"];
            }
          ];
          preferences = {
            includeInlayParameterNameHints = "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = false;
            includeInlayFunctionParameterTypeHints = false;
            includeInlayVariableTypeHints = false;
            includeInlayVariableTypeHintsWhenTypeMatchesName = false;
            includeInlayPropertyDeclarationTypeHints = true;
            includeInlayFunctionLikeReturnTypeHints = true;
            includeInlayEnumMemberValueHints = true;
          };
        };
        biome = {
          command = "biome";
          args = ["lsp-proxy"];
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
          name = "typescript";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "vscode-eslint-language-server"
            "biome"
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "tailwindcss"
            "vscode-eslint-language-server"
            "biome"
          ];
        }
        {
          name = "vue";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "vscode-eslint-language-server"
            "vuels"
            "efm"
          ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = ["--parser" "vue"];
          };
        }
        {
          name = "kdl";
          auto-format = true;
          formatter = {
            command = "kdlfmt";
            args = ["format" "-"];
          };
        }
      ];
    };
  };
}
