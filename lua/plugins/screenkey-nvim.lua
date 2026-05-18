vim.pack.add({ "https://github.com/nstefan002/screenkey.nvim" }, { load = false })

require("lz.n").load({
  "screenkey",
  after = function()
    require("screenkey").setup({})
  end,
  cmd = { "Screenkey" },
  lazy = true,
})
