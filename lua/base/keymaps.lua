-- Set up globals {{{
do
  local nixvim_globals = {
    mapleader = " ",
    skip_ts_context_commentstring_module = true,
  }

  for k, v in pairs(nixvim_globals) do
    vim.g[k] = v
  end
end

-- Set up keybinds {{{
do
  local __nixvim_binds = {
    { action = "<Nop>", key = "<Space>", mode = "", options = { silent = true } },
    { action = ":w<CR>", key = "S", mode = "n", options = { desc = "save file", silent = true } },
    { action = ":qa<CR>", key = "Q", mode = "n", options = { desc = "quit neovim", silent = true } },
    { action = "<ESC>", key = "jk", mode = "i", options = { desc = "exit insert mode", silent = true } },
    { action = "<C-w>h", key = "<C-h>", mode = "n", options = { silent = true } },
    { action = "<C-w>j", key = "<C-j>", mode = "n", options = { silent = true } },
    { action = "<C-w>k", key = "<C-k>", mode = "n", options = { silent = true } },
    { action = "<C-w>l", key = "<C-l>", mode = "n", options = { silent = true } },
    { action = ":bnext<CR>", key = "<TAB>", mode = "n", options = { silent = true } },
    { action = ":bprevious<CR>", key = "<S-TAB>", mode = "n", options = { silent = true } },
    { action = "<gv", key = "<", mode = "v", options = { silent = true } },
    { action = ">gv", key = ">", mode = "v", options = { silent = true } },
    { action = ":move '>+1<CR>gv-gv", key = "J", mode = "x", options = { silent = true } },
    { action = ":move '<-2<CR>gv-gv", key = "K", mode = "x", options = { silent = true } },
    { action = ":move '>+1<CR>gv-gv", key = "J", mode = "v", options = { silent = true } },
    { action = ":move '<-2<CR>gv-gv", key = "K", mode = "v", options = { silent = true } },
    { action = "<Nop>", key = "s", mode = "", options = { silent = true } },
    { action = ":set splitright<CR>:vsplit<CR>", key = "sl", mode = "n", options = { silent = true } },
    { action = ":set nosplitright<CR>:vsplit<CR>", key = "sh", mode = "n", options = { silent = true } },
    { action = ":set nosplitbelow<CR>:split<CR>", key = "sk", mode = "n", options = { silent = true } },
    { action = ":set splitbelow<CR>:split<CR>", key = "sj", mode = "n", options = { silent = true } },
    {
      action = "<C-w>=",
      key = "<C-=>",
      mode = "n",
      options = { desc = "average adjustment window", silent = true },
    },
    { action = "<C-w>H", key = "<Space>h", mode = "n", options = { silent = true } },
    { action = "<C-w>J", key = "<Space>j", mode = "n", options = { silent = true } },
    { action = "<C-w>K", key = "<Space>k", mode = "n", options = { silent = true } },
    { action = "<C-w>L", key = "<Space>l", mode = "n", options = { silent = true } },
    { action = "<C-w>t<C-w>K", key = ",", mode = "n", options = { silent = true } },
    { action = "<C-w>t<C-w>H", key = ".", mode = "n", options = { silent = true } },
    { action = ":resize -2<CR>", key = "<C-Down>", mode = "n", options = { silent = true } },
    { action = ":resize +2<CR>", key = "<C-Up>", mode = "n", options = { silent = true } },
    { action = ":vertical resize -2<CR>", key = "<C-Left>", mode = "n", options = { silent = true } },
    { action = ":vertical resize +2<CR>", key = "<C-Right>", mode = "n", options = { silent = true } },
    { action = ":nohlsearch<CR>", key = "<Space><CR>", mode = "n", options = { silent = true } },
    { action = "nzz", key = "n", mode = "n", options = { silent = true } },
    { action = "Nzz", key = "N", mode = "n", options = { silent = true } },
    { action = ":tabnew<CR>", key = "<C-n>", mode = "n", options = { desc = "new tab", silent = true } },
    { action = "5k", key = "<C-u>", mode = "n", options = { silent = true } },
    { action = "5j", key = "<C-d>", mode = "n", options = { silent = true } },
    { action = "$", key = "<C-.>", mode = "n", options = { silent = true } },
    { action = "<ESC>$", key = "<C-.>", mode = "i", options = { silent = true } },
    { action = "$", key = "<C-.>", mode = "x", options = { silent = true } },
    { action = "$", key = "<C-.>", mode = "v", options = { silent = true } },
    { action = "^", key = "<C-,>", mode = "n", options = { silent = true } },
    { action = "<ESC>^", key = "<C-,>", mode = "i", options = { silent = true } },
    { action = "^", key = "<C-,>", mode = "x", options = { silent = true } },
    { action = "^", key = "<C-,>", mode = "v", options = { silent = true } },
    { action = '"_dP', key = "p", mode = "v", options = { silent = true } },
  }
  for i, map in ipairs(__nixvim_binds) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
  end
end
-- }}}
