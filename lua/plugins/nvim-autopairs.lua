vim.pack.add({ "https://github.com/windwp/nvim-autopairs" }, { lazy = false })

require("lz.n").load({
  "nvim-autopairs",
  after = function()
    require("nvim-autopairs").setup({})
  end,
  event = { "InsertEnter" },
})
