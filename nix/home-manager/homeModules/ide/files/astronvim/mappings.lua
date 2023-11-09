-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

    ["<leader>hw"] = { "<cmd>HopWord<cr>", desc = "Hop to word" },
    ["<leader>ht"] = { "<cmd>HopChar2<cr>", desc = "Hop to char" },
    ["<leader>h"] = { name = "Hop", desc = "➴ Hop" },
    ["<leader>lx"] = { "<cmd>LspRestart<cr>", desc = "Restart LSP" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["<"] = { "<gv", desc = "Shift left" },
    [">"] = { ">gv", desc = "Shift right" },
  }
}
