vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", load = false } })

require("lz.n").load({
  "nvim-treesitter-textobjects",
  keys = {
    {
      "if",
      "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')<CR>",
      desc = "Inner function",
      mode = { "x", "o" },
    },
    {
      "af",
      "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')<CR>",
      desc = "Around function",
      mode = { "x", "o" },
    },
    {
      "ic",
      "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')<CR>",
      desc = "Inner class",
      mode = { "x", "o" },
    },
    {
      "ac",
      "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')<CR>",
      desc = "Around class",
      mode = { "x", "o" },
    },
    {
      "ii",
      "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@conditional.inner', 'textobjects')<CR>",
      desc = "Inner conditional",
      mode = { "x", "o" },
    },
    {
      "ai",
      "<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@conditional.outer', 'textobjects')<CR>",
      desc = "Around conditional",
      mode = { "x", "o" },
    },
    {
      "]m",
      "<cmd>lua require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer')<CR>",
      desc = "Next function start",
    },
    {
      "[m",
      "<cmd>lua require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer')<CR>",
      desc = "Prev function start",
    },
    {
      "]]",
      "<cmd>lua require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer')<CR>",
      desc = "Next class start",
    },
    {
      "[[",
      "<cmd>lua require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer')<CR>",
      desc = "Prev class start",
    },
  },
})
