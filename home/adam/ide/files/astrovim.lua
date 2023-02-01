return {
  colorscheme = "nord",
  options = {
    g = {
      nord_disable_background = true,
      terraform_fmt_on_save = 1,
    },
  },
  mappings = {
    n = {
      ["<leader>h"] = {},
      ["<leader>hw"] = { "<cmd>HopWord<cr>", desc = "Hop word" },
      ["<leader>hc"] = { "<cmd>HopChar2<cr>", desc = "Hop to char" }
    }
  },
  lsp = {
    servers = {
      "rnix",
    },
  },
  dap = {
    adapters = {
      ruby = {
        type = "server",
        host = "127.0.0.1",
        port = 2345,
      }
    },
    configurations = {
      ruby = { {
        type = "ruby",
        name = "Attach to ruby debug",
        request = "attach",
        mode = "remote",
        host = "127.0.0.1",
        port = 2345
      } }
    }
  },
  plugins = {
    init = {
      ["phaazon/hop.nvim"] = {
        config = function()
          require('hop').setup()
        end
      }
    },
    notify = {
      background_colour = "#000000"
    },
    ["which-key"] = {
      register = {
        n = {
          ["<leader>"] = {
            h = { name = "Hop" },
          }
        }
      }
    },
    ["neo-tree"] = {
      enable_diagnostics = true,
      default_component_configs = {
        indent = {
          padding = 1
        }
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false
        },
        hijack_netrw_behavior = "open_split",
        window = {
          mappings = {
            ["h"] = function(state)
              local node = state.tree:get_node()
              if node.type == 'directory' and node:is_expanded() then
                require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
              else
                require 'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
              end
            end,
            ["l"] = function(state)
              local node = state.tree:get_node()
              if node.type == 'directory' then
                if not node:is_expanded() then
                  require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
                elseif node:has_children() then
                  require 'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
                end
              end
            end,
          }
        }
      }
    },
    treesitter = {
      ensure_installed = { "lua", "nix" }
    },
    ["mason-null-ls"] = {
      ensure_installed = { "lua-language-server", "gopls", "goimports-reviser" },
    },
  },
  ["mason-nvim-dap"] = {
    setup_handlers = {
      delve = function(source_name)
        local dap = require("dap")
        dap.adapters.delve = {
          type = "server",
          host = "127.0.0.1",
          port = 2345,
        }
        dap.configurations.go = {
          {
            type = "delve",
            name = "Attach to Delve",
            request = "attach",
            mode = "remote",
            host = "127.0.0.1",
            port = 2345,
          },
        }
      end,
    },
  },

  polish = function()
    vim.api.nvim_create_augroup("neotree", {})
    vim.api.nvim_create_autocmd("UiEnter", {
      desc = "Open Neotree automatically",
      group = "neotree",
      callback = function()
        if vim.fn.argc() == 0 and not vim.fn.exists "s:std_in" then
          vim.cmd "Neotree show"
        end
      end,
    })
  end,
}
