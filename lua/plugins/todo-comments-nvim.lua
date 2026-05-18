vim.pack.add({ "https://github.com/folke/todo-comments.nvim" }, { load = false })

require("lz.n").load({
  "todo-comments.nvim",
  after = function()
    require("todo-comments").setup({})
  end,
  event = { "InsertEnter" },
})
