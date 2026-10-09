vim.pack.add({ "https://github.com/voldikss/vim-translator" }, { load = false })

require("lz.n").load({
  "vim-translator",
  lazy = true,
  keys = {
    { "<leader>d", "<Plug>TranslateW", desc = "Display translation in a window" },
    { "<leader>d", "<Plug>TranslateWV", desc = "Display translation in a window", mode = { "v" } },
  },
})
