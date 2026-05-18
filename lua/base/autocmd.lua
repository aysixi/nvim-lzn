-- ==========================================================================
-- 1. 自动跳转到上一次编辑的位置 (Jump to the last edit position)
-- ==========================================================================
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]],
})

-- ==========================================================================
-- 2. 保存时自动清除行尾空格 (Automatically remove trailing whitespace before saving)
-- ==========================================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- ==========================================================================
-- 3. 打开文件时自动切换工作目录 (Auto-change directory to project root)
-- ==========================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local path = vim.fn.expand("%:p")
    if path == "" or vim.bo.buftype ~= "" then
      return
    end

    local root = vim.fs.find({ ".repo", ".git" }, {
      path = path,
      upward = true,
    })[1]

    if root then
      pcall(vim.api.nvim_set_current_dir, vim.fs.dirname(root))
    else
      local file_dir = vim.fn.expand("%:p:h")
      if file_dir and file_dir ~= "" and vim.fn.isdirectory(file_dir) == 1 then
        pcall(vim.api.nvim_set_current_dir, file_dir)
      end
    end
  end,
})

-- ==========================================================================
-- 4. 根据 LSP 自动修正工作目录 (Override cwd with LSP root_dir when LSP attaches)
-- ==========================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.config.root_dir then
      pcall(vim.api.nvim_set_current_dir, client.config.root_dir)
    end
  end,
})

-- ==========================================================================
-- 5. 窄窗口自动隐藏颜色列 (Hide colorcolumn on narrow windows)
-- ==========================================================================
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.o.columns < 120 then
      vim.opt_local.colorcolumn = {}
    else
      vim.opt_local.colorcolumn = { "80", "120" }
    end
  end,
})

-- ==========================================================================
-- 6. 自动保存代码折叠状态 (Save folding state)
-- ==========================================================================
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    pcall(function()
      vim.cmd("mkview")
    end)
  end,
})

-- ==========================================================================
-- 7. 自动恢复代码折叠状态 (Restore folding state)
-- ==========================================================================
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    pcall(function()
      vim.cmd("loadview")
    end)
  end,
})
