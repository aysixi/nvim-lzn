vim.pack.add({ "https://github.com/mistricky/codesnap.nvim" }, { load = false })

require("lz.n").load({
  "codesnap.nvim",
  after = function()
    require("codesnap").setup({
      bg_padding = 0,
      breadcrumbs_separator = "/",
      code_font_family = "Maple Mono NF CN",
      has_breadcrumbs = true,
      has_line_number = true,
      save_path = "~/Pictures/",
      show_workspace = true,
      watermark = "",
    })
  end,
  cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII", "CodeSnapHighlight" },
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", desc = "Save selected code snapshot into clipboard", mode = { "x" } },
    {
      "<leader>cs",
      "<cmd>CodeSnapSave<cr>",
      desc = "Save selected code snapshot in ~/Pictures",
      mode = { "x" },
    },
  },
  lazy = false,
})
