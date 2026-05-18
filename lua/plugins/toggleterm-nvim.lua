vim.pack.add { { src = "https://github.com/akinsho/toggleterm.nvim" } }

require("toggleterm").setup({
  close_on_exit = true,
  direction = "horizontal",
  float_opts = {
    border = "single",
    height = 20,
    highlights = { background = "Normal", border = "Normal" },
    width = 80,
    winblend = 0,
  },
  hide_numbers = true,
  insert_mappings = true,
  open_mapping = [[<c-\>]],
  persist_size = true,
  shade_terminals = false,
  shell = vim.o.shell,
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  start_in_insert = true,
  terminal_mappings = true,
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end,
  },
})

function runFile()
  local ft = vim.bo.filetype
  local run_cmd = { go = "go run %", rust = "cargo run", cpp = "cppup run" }
  local cmd = run_cmd[ft]
  if not cmd then
    vim.notify("No run command defined for filetype: " .. ft, vim.log.levels.WARN)
    return
  end
  local exe = cmd:match("^(%S+)")
  if vim.fn.executable(exe) == 0 then
    vim.notify("Command not found: " .. exe, vim.log.levels.ERROR)
    return
  end
  vim.cmd("TermExec cmd=" .. "'clear;" .. cmd .. "' go_back=0")
end

vim.keymap.set("n", "<space>r", "<cmd>lua runFile()<CR>", { noremap = true, silent = true, desc = "Run current file" })

function _G.toggle_new_terminal()
  local terms = require("toggleterm.terminal").get_all()
  vim.cmd((#terms + 1) .. "ToggleTerm")
end

function _G.kill_curr_terminal()
  local id = vim.b.toggle_number
  if id then
    require("toggleterm.terminal").get(id):shutdown()
  else
    if vim.bo.buftype == "terminal" then
      vim.cmd("bdelete!")
    end
  end
end

vim.keymap.set({ "n", "t" }, "<C-S-\\>", _G.toggle_new_terminal, { desc = "New terminal" })
vim.keymap.set({ "n", "t" }, "<C-|>", _G.toggle_new_terminal, { desc = "New terminal" })
vim.keymap.set({ "n", "t" }, "<C-q>", _G.kill_curr_terminal, { desc = "Kill terminal" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-w>h", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-w>j", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-w>k", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-w>l", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
