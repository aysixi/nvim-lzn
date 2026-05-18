vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" }, { load = false })

require("lz.n").load({
  "gitsigns.nvim",
  after = function()
    require("gitsigns").setup({})
  end,
  event = { "BufRead" },
})
