vim.pack.add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/folke/noice.nvim",
})

require("noice").setup({
  lsp = {
    signature = { auto_open = { enabled = false }, enabled = true },
    -- 新增以下 override 配置，用来消除 checkhealth 的 2 个警告
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- 如果你使用了 nvim-cmp 补全，强烈建议一起开启
    },
  },
  presets = { inc_rename = true, lsp_doc_border = true },
  routes = {
    {
      filter = {
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
          { find = "%d fewer lines" },
          { find = "%d more lines" },
          { find = "Agent service not initialized" },
        },
        event = "msg_show",
      },
      opts = { skip = true },
    },
  },
})

-- 你原有的 gitblame 配置保持不变即可
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
