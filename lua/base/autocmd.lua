-- Set up autogroups {{
do
  local __nixvim_autogroups = {
    nixvim_binds_LspAttach = { clear = true },
    nixvim_lsp_binds = { clear = false },
    nixvim_lsp_on_attach = { clear = false },
  }

  for group_name, options in pairs(__nixvim_autogroups) do
    vim.api.nvim_create_augroup(group_name, options)
  end
end
-- }}
--
-- Set up autocommands {{
do
  local __nixvim_autocommands = {
    {
      callback = function()
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
      end,
      event = "FileType",
      group = "nixvim_treesitter",
      pattern = "*",
    },
    {
      callback = function(event)
        do
          -- client and bufnr are supplied to the builtin `on_attach` callback,
          -- so make them available in scope for our global `onAttach` impl
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local bufnr = event.buf
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
              local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "line",
              }
              vim.diagnostic.show()
              vim.diagnostic.open_float(nil, opts)
            end,
          })

          local auto_format_servers = { "rust_analyzer", "hls", "mesonlsp" }
          if vim.tbl_contains(auto_format_servers, client.name) then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false, id = client.id })
              end,
            })
          end
        end
      end,
      desc = "Run LSP onAttach",
      event = "LspAttach",
      group = "nixvim_lsp_on_attach",
    },
    {
      callback = function(args)
        local __keymaps = {
          {
            action = vim.lsp.buf["definition"],
            key = "gd",
            mode = "",
            options = {
              buffer = true,
              desc = "Go to definition",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["declaration"],
            key = "gD",
            mode = "",
            options = {
              buffer = true,
              desc = "Go to declaration",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["implementation"],
            key = "gi",
            mode = "",
            options = {
              buffer = true,
              desc = "Go to implementation",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["references"],
            key = "gr",
            mode = "",
            options = {
              buffer = true,
              desc = "Find references",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["hover"],
            key = "K",
            mode = "",
            options = {
              buffer = true,
              desc = "Hover documentation",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["type_definition"],
            key = "<leader>D",
            mode = "",
            options = {
              buffer = true,
              desc = "Go to type definition",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["signature_help"],
            key = "<leader>s",
            mode = "",
            options = {
              buffer = true,
              desc = "Show signature help",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["add_workspace_folder"],
            key = "<leader>wa",
            mode = "",
            options = {
              buffer = true,
              desc = "Add workspace folder",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["remove_workspace_folder"],
            key = "<leader>wr",
            mode = "",
            options = {
              buffer = true,
              desc = "Remove workspace folder",
              noremap = true,
              silent = true,
            },
          },
          {
            action = function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            key = "<leader>wl",
            mode = "",
            options = {
              buffer = true,
              desc = "List workspace folders",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["rename"],
            key = "<leader>n",
            mode = "",
            options = {
              buffer = true,
              desc = "Rename symbol",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["code_action"],
            key = "<leader>ca",
            mode = "",
            options = {
              buffer = true,
              desc = "Code actions",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.lsp.buf["format"],
            key = "<leader>f",
            mode = {
              "n",
              "v",
            },
            options = {
              buffer = true,
              desc = "Format code",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.diagnostic.goto_prev,
            key = "[d",
            mode = "",
            options = {
              buffer = true,
              desc = "Go to previous diagnostic",
              noremap = true,
              silent = true,
            },
          },
          {
            action = vim.diagnostic.goto_next,
            key = "]d",
            mode = "",
            options = {
              buffer = true,
              desc = "Go to next diagnostic",
              noremap = true,
              silent = true,
            },
          },
          {
            action = function()
              print(vim.inspect(vim.lsp.get_clients({ bufnr = bufnr })))
            end,
            key = "<leader>L",
            mode = "",
            options = {
              buffer = true,
              desc = "List LSP clients",
              noremap = true,
              silent = true,
            },
          },
        }

        for _, keymap in ipairs(__keymaps) do
          local options = vim.tbl_extend("keep", keymap.options or {}, { buffer = args.buf })
          vim.keymap.set(keymap.mode, keymap.key, keymap.action, options)
        end
      end,
      desc = "Load LSP keymaps",
      event = "LspAttach",
      group = "nixvim_lsp_binds",
    },
    {
      callback = function(args)
        do
          local __nixvim_binds = {}

          for i, map in ipairs(__nixvim_binds) do
            local options = vim.tbl_extend("keep", map.options or {}, { buffer = args.buf })
            vim.keymap.set(map.mode, map.key, map.action, options)
          end
        end
      end,
      desc = "Load keymaps for LspAttach",
      event = "LspAttach",
      group = "nixvim_binds_LspAttach",
    },
    {
      command = 'if line("\'\\"") > 1 && line("\'\\"") <= line("$") |\n\texe "normal! g`\\""\nendif\n',
      event = { "BufReadPost" },
      pattern = { "*" },
    },
    { command = "%s/\\s\\+$//e", event = { "BufWritePre" }, pattern = { "*" } },
    {
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
      event = { "FileType" },
      pattern = { "*" },
    },
    {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.config.root_dir then
          pcall(vim.api.nvim_set_current_dir, client.config.root_dir)
        end
      end,
      event = { "LspAttach" },
      pattern = { "*" },
    },
    {
      callback = function()
        if vim.o.columns < 120 then
          vim.opt_local.colorcolumn = {}
        else
          vim.opt_local.colorcolumn = { "80", "120" }
        end
      end,
      event = { "VimResized", "BufEnter" },
      pattern = { "*" },
    },
    {
      callback = function()
        pcall(function()
          vim.cmd("mkview")
        end)
      end,
      event = { "BufWinLeave" },
      pattern = { "*" },
    },
    {
      callback = function()
        pcall(function()
          vim.cmd("loadview")
        end)
      end,
      event = { "BufRead" },
      pattern = { "*" },
    },
  }

  for _, autocmd in ipairs(__nixvim_autocommands) do
    vim.api.nvim_create_autocmd(autocmd.event, {
      group = autocmd.group,
      pattern = autocmd.pattern,
      buffer = autocmd.buffer,
      desc = autocmd.desc,
      callback = autocmd.callback,
      command = autocmd.command,
      once = autocmd.once,
      nested = autocmd.nested,
    })
  end
end
-- }}
