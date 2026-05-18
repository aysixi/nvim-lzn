vim.pack.add({
  "https://github.com/numtostr/comment.nvim",
  "https://github.com/joosepalviste/nvim-ts-context-commentstring",
}, { load = false })

require("lz.n").load({
  "comment.nvim",
  after = function()
    require("Comment").setup({
      extra = { above = "gco", below = "gco", eol = "gca" },
      mappings = { basic = true, extra = true },
      opleader = { block = "gb", line = "gc" },
      padding = true,
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      sticky = true,
      toggler = { block = "gbc", line = "gcc" },
    })
  end,
  event = { "bufreadpost" },
})
