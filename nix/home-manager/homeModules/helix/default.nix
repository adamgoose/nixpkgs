{
  pkgs,
  inputs,
  unstable,
  ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix.packages.helix;
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
          language-servers = ["typescript-language-server" "vscode-eslint-language-server"];
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
        }
        {
          name = "tsx";
          auto-format = true;
          language-servers = ["typescript-language-server" "tailwindcss" "vscode-eslint-language-server"];
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
        }
        {
          name = "vue";
          language-servers = ["typescript-language-server" "vscode-eslint-language-server" "vuels" "efm"];
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
