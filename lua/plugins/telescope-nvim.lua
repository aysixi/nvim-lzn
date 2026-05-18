vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" }, { load = false })

require("lz.n").load({
  "telescope.nvim",
  after = function()
    require("telescope").setup({})

    local __telescopeExtensions = {}
    for i, extension in ipairs(__telescopeExtensions) do
      require("telescope").load_extension(extension)
    end
  end,
  keys = { { "<leader>e", "<cmd>Telescope<cr>", desc = "Telescope" } },
})
