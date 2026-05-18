vim.pack.add({ "https://github.com/f-person/git-blame.nvim" })

require("gitblame").setup({
  date_format = "%m-%d-%Y %H:%M:%S",
  message_template = "<summary> • <date> • <author> • <<sha>>",
})
