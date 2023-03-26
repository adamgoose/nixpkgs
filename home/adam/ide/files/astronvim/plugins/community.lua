return {
  -- Add the community repository of plugin specifications
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.colorscheme.catppuccin",    enabled = true },
  {
    "catppuccin",
    opts = {
      transparent_background = true
    },
  },

  { import = "astrocommunity.completion.copilot-lua-cmp" },
}
