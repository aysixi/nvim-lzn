vim.pack.add({ "https://github.com/kdheepak/lazygit.nvim" }, { load = false })

require("lz.n").load({
  "lazygit.nvim",
  cmd = "LazyGit",
  keys = { { "<leader>*", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
})
