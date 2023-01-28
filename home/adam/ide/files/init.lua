return {
  options = {
    g = {
      nord_disable_background = true,
      terraform_fmt_on_save = 1,
    },
  },
  colorscheme = "nord",
  lsp = {
    servers = {
      "rnix",
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
}
