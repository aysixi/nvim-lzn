vim.pack.add({
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
}, { load = false })

require("lz.n").load({
  "vim-dadbod-ui",
  before = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  event = { "BufRead" },
}, { "vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } }, { "vim-dadbod", ft = { "sql", "mysql", "plsql" } }, {
  "undotree",
  before = function()
    local globals = {
      undotree_CursorLine = true,
      undotree_DiffAutoOpen = true,
      undotree_DiffCommand = "diff",
      undotree_DiffpanelHeight = 10,
      undotree_HelpLine = true,
      undotree_HighlightChangedText = true,
      undotree_HighlightChangedWithSign = true,
      undotree_HighlightSyntaxAdd = "DiffAdd",
      undotree_HighlightSyntaxChange = "DiffChange",
      undotree_HighlightSyntaxDel = "DiffDelete",
      undotree_RelativeTimestamp = true,
      undotree_SetFocusWhenToggle = true,
      undotree_ShortIndicators = false,
      undotree_SplitWidth = 40,
      undotree_TreeNodeShape = "*",
      undotree_TreeReturnShape = "\\",
      undotree_TreeSplitShape = "/",
      undotree_TreeVertShape = "|",
      undotree_WindowLayout = 4,
    }

    for k, v in pairs(globals) do
      vim.g[k] = v
    end
  end,
  keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" } },
})
