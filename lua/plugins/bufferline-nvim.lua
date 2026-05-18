vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" }, { load = false })

require("lz.n").load({
  "bufferline.nvim",
  after = function()
    local highlights = require("catppuccin.special.bufferline").get_theme()
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
          },
        },
      },
      highlights = highlights,
    })
  end,
  lazy = false,
})
