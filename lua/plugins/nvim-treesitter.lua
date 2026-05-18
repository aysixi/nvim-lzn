vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter" } })

-- Create autogroup for treesitter autocmds
local augroup = vim.api.nvim_create_augroup("nixvim_treesitter", { clear = true })

-- Detect nvim-treesitter API
local has_configs_module = pcall(require, "nvim-treesitter.configs")

if has_configs_module then
  require("nvim-treesitter.configs").setup({})
else
  require("nvim-treesitter").setup({})

  -- Enable features via autocommands for modern nvim-treesitter
  local disabled_highlight = {}

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "*",
    callback = function(args)
      local filetype = vim.bo[args.buf].filetype
      local lang = vim.treesitter.language.get_lang(filetype) or filetype
      local start_highlight = true

      for _, disabled in ipairs(disabled_highlight) do
        if disabled == lang or disabled == filetype then
          start_highlight = false
          break
        end
      end

      if start_highlight then
        pcall(vim.treesitter.start, args.buf, lang)
      end
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

-- Treesitter injection for Nix strings (e.g., __raw)
local nix_injection_query = [[
  ((binding
    attrpath: (attrpath (identifier) @_name)
    expression: (string_expression (string_fragment) @injection.content))
   (#match? @_name "(__raw)$")
   (#set! injection.language "lua"))
]]
vim.treesitter.query.set("nix", "injections", nix_injection_query)
