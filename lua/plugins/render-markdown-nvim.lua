vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, { load = false })

require("lz.n").load({
  "render-markdown.nvim",
  after = function()
    require("render-markdown").setup({ file_types = { "markdown", "Avante" } })
  end,
  ft = { "markdown", "Avante" },
})
