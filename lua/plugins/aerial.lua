vim.pack.add({ "https://github.com/stevearc/aerial.nvim" }, { load = false })

require("lz.n").load({
  "aerial.nvim",
  after = function()
    require("aerial").setup({
      layout = { default_direction = "prefer_right", max_width = { 40, 0.2 }, min_width = 25 },
      nav = { preview = true },
      show_guides = true,
    })
  end,
  keys = { { "<leader>o", "<cmd>AerialNavToggle<cr>", desc = "Toggle aerial outline" } },
})
