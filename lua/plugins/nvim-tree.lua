vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })

require("lz.n").load({
  "nvim-tree.lua",
  after = function()
    require("nvim-tree").setup({
      filters = { dotfiles = true },
      renderer = { group_empty = true },
      sort_by = "case_sensitive",
      view = { side = "left", width = 25 },
    })

    -- Telescope integration for searching inside the folder under the cursor or current buffer's directory
    vim.keymap.set("n", "<leader>g", function()
      local path
      if vim.bo.filetype == "NvimTree" then
        local api = require("nvim-tree.api")
        local node = api.tree.get_node_under_cursor()
        path = node and node.absolute_path or vim.loop.cwd()
      else
        path = vim.api.nvim_buf_get_name(0)
        if path == "" then
          path = vim.loop.cwd()
        end
      end

      local stat = vim.loop.fs_stat(path)
      if stat and stat.type == "file" then
        path = vim.fn.fnamemodify(path, ":h")
      end

      require("telescope.builtin").live_grep({
        search_dirs = { path },
      })
    end, { desc = "Live grep in current directory" })
  end,
  before = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    local lzn = require("lz.n")
    lzn.trigger_load({
      "telescope.nvim",
    })
  end,
  keys = {
    { "tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
    { "gF", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Jump to current file's directory" },
  },
})
