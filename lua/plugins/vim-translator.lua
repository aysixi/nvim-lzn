vim.pack.add({ "https://github.com/voldikss/vim-translator" }, { name = "vim-translator" }, { load = false })

require("lz.n").load({
  "vim-translator",
  keys = {
    { "<leader>d", "<Plug>TranslateW", desc = "Display translation in a window" },
    { "<leader>d", "<Plug>TranslateWV", desc = "Display translation in a window", mode = { "v" } },
  },
  lazy = true,
})
