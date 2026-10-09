vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })

require("colorizer").setup({
  user_default_options = {
    AARRGGBB = true,
    RGB = true,
    RRGGBB = true,
    RRGGBBAA = true,
    mode = "background",
    names = false,
  },
})
