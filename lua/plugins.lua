local plugins = {
  -- theme
  "catppuccin",

  -- filetree
  "nvim-tree",

  -- terminal
  "toggleterm-nvim",

  -- treesitter
  "nvim-treesitter",
  "nvim-treesitter-textobjects",

  -- utils
  "noice-nvim",
  "comment-nvim",
  "nvim-web-devicons",
  "vim-dadbod-ui",
  "nvim-autopairs",
  "nvim-surround",
  "todo-comments-nvim",
  "undotree",
  "aerial",
  "screenkey-nvim",
  "vim-translator",
  "markdown-preview-nvim",
  "codesnap-nvim",
  "nvim-colorizer",

  -- git
  "gitsigns-nvim",
  "diffview-nvim",
  "lazygit-nvim",
  "git-blame-nvim",

  -- fuzzy_finder
  "telescope-nvim",

  -- lsp
  "trouble-nvim",
  "nvim-lspconfig",
  "none-ls",

  -- completion
  "blink-cmp",

  -- statusline
  "lualine-nvim",

  -- motion
  "flash-nvim",

  -- tabline
  "bufferline-nvim",

  -- indent
  "indent-blankline-nvim",

  -- syntax
  "rainbow-delimiters-nvim",
  "render-markdown-nvim",

  -- keybinding
  "which-key-nvim",

  --ai
  "avante-nvim",
}

for _, plugin in ipairs(plugins) do
  local plugin_path = "plugins." .. plugin
  local status_ok, _ = pcall(require, plugin_path)
  if not status_ok then
    vim.notify("error: no file " .. plugin_path, vim.log.levels.WARN)
  end
end
