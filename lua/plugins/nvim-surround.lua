vim.pack.add({ "https://github.com/kylechui/nvim-surround" }, { load = false })

require("lz.n").load({
  "nvim-surround",
  after = function()
    require("nvim-surround").setup({})
  end,
  event = { "BufReadPost" },
})
