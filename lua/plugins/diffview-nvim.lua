vim.pack.add({ "https://github.com/sindrets/diffview.nvim" }, { load = false })

require("lz.n").load({
  "diffview.nvim",
  after = function()
    require("diffview").setup({ diff_binaries = true, enhanced_diff_hl = true, use_icons = true })
  end,
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
})
