---@type LazySpec
return {
  "jackMort/ChatGPT.nvim",
  -- event = "VeryLazy",
  cmd = {
    "ChatGPT",
    "ChatGPTEditWithInstruction",
    "ChatGPTRun",
  },
  config = function()
    require("chatgpt").setup {
      api_key_cmd = "op read op://Private/OpenAI/credential --no-newline",
      openai_params = {
        model = "gpt-4o",
      },
      openai_edit_params = {
        model = "gpt-4o",
      },
    }
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
