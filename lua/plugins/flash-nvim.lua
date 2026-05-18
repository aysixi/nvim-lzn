vim.pack.add({ "https://github.com/folke/flash.nvim" }, { load = false })

require("lz.n").load({
  "flash.nvim",
  after = function()
    require("flash").setup({
      jump = { autojump = false },
      label = { rainbow = { enabled = false, shade = 5 } },
      labels = "asdfghjklqwertyuiopzxcvbnm",
      modes = { char = { jump_labels = true, label = { exclude = "" } } },
      prompt = { enabled = true, prefix = { { "🔎", "FlashPromptIcon" } } },
      search = { mode = "fuzzy" },
    })
  end,
  keys = {
    {
      "<c-f>",
      function()
        require("flash").jump()
      end,
      desc = "Flash",
      mode = { "n", "x", "o" },
    },
    {
      "<leader>t",
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
      mode = { "n", "o", "x" },
    },
    {
      "<leader>T",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
      mode = { "n", "o", "x" },
    },
    {
      "<leader>-",
      function()
        require("flash").treesitter_search()
      end,
      desc = "Flash Treesitter Search",
      mode = { "n", "o", "x" },
    },
  },
})
