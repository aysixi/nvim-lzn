vim.pack.add(
  { "https://github.com/latex-lsp/tree-sitter-latex", "https://github.com/iamcco/markdown-preview.nvim" },
  { load = false }
)

require("lz.n").load({
  "markdown-preview.nvim",
  before = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = { { "mp", "<cmd>MarkdownPreview<cr>", desc = "Toggle markdown-preview" } },
})
