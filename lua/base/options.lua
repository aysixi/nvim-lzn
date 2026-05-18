-- Set up options {{{
do
  local nixvim_options = {
    autoindent = true,
    clipboard = "unnamedplus",
    cmdheight = 1,
    cursorcolumn = false,
    cursorline = false,
    expandtab = true,
    exrc = true,
    fileencodings = "utf-8,gbk",
    foldenable = false,
    foldlevel = 99,
    hidden = true,
    ignorecase = true,
    laststatus = 3,
    mouse = "a",
    number = true,
    numberwidth = 4,
    relativenumber = true,
    scrolloff = 8,
    shiftwidth = 2,
    showmode = false,
    showtabline = 2,
    smartcase = true,
    smartindent = true,
    swapfile = true,
    tabstop = 2,
    undofile = true,
    updatetime = 50,
    wrap = true,
  }

  for k, v in pairs(nixvim_options) do
    vim.opt[k] = v
  end
end
-- }}}
