vim.pack.add({ { src = "https://github.com/neovim/nvim-lspconfig", load = false } })

require("lz.n").load({
  {
    "nvim-lspconfig",
    after = function() end,
    before = function()
      local lzn = require("lz.n")
      lzn.trigger_load({
        "blink.cmp",
      })
    end,
  },
})

-- LSP {{{
do
  vim.lsp.inlay_hint.enable(true)
  local __lspCapabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Capabilities configuration for blink-cmp
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    return capabilities
  end

  local __setup = { capabilities = __lspCapabilities() }

  local __wrapConfig = function(cfg)
    if cfg == nil then
      cfg = __setup
    else
      cfg = vim.tbl_extend("keep", cfg, __setup)
    end
    return cfg
  end

  vim.lsp.enable("bashls")
  vim.lsp.config("clangd", {
    capabilities = {
      offsetEncoding = { "utf-8", "utf-16" },
      textDocument = { completion = { editsNearCursor = true } },
    },
    cmd = (function()
      local function get_compile_commands_dir()
        local dir = os.getenv("COMPILE_COMMANDS_DIR")
        if dir and vim.fn.isdirectory(dir) == 1 then
          return dir
        end
        return (_G.root_dir or vim.fn.getcwd()) .. "/build"
      end

      local function get_clangd_path()
        local path = os.getenv("CLANGD_PATH")
        if path and vim.fn.filereadable(path) == 1 then
          return path
        end
        local system_path = vim.fn.exepath("clangd")
        if system_path ~= "" then
          return system_path
        end
        return "clangd"
      end

      local function get_query_drivers()
        local detected = {
          vim.fn.exepath("clang"),
          vim.fn.exepath("clang++"),
          vim.fn.exepath("gcc"),
          vim.fn.exepath("g++"),
          vim.fn.exepath("c++"),
          os.getenv("CLANG_PATH"),
          os.getenv("CXX"),
        }

        local valid = {}
        local seen = {}
        for _, d in ipairs(detected) do
          if d and d ~= "" and not seen[d] then
            table.insert(valid, d)
            seen[d] = true
          end
        end

        if #valid == 0 then
          return "clang,gcc,c++,g++"
        end

        return table.concat(valid, ",")
      end

      return {
        get_clangd_path(),
        "--enable-config",
        "--pch-storage=memory",
        "--compile-commands-dir=" .. get_compile_commands_dir(),
        "--background-index",
        "--clang-tidy",
        "--log=verbose",
        "--all-scopes-completion",
        "--header-insertion=iwyu",
        "--fallback-style=LLVM",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--pretty",
        "--query-driver=" .. get_query_drivers(),
      }
    end)(),
  })
  vim.lsp.enable("clangd")
  vim.lsp.enable("cmake")
  vim.lsp.enable("cssls")
  vim.lsp.config("gopls", {
    init_options = { usePlaceholders = true },
    settings = {
      gopls = {
        analyses = { shadow = true, unusedparams = true },
        experimentalPostfixCompletions = true,
        gofumpt = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        staticcheck = true,
      },
    },
  })
  vim.lsp.enable("gopls")
  vim.lsp.enable("hls")
  vim.lsp.enable("html")
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        runtime = { version = "LuaJIT" },
        telemetry = { enable = false },
        workspace = { checkThirdParty = false },
      },
    },
  })
  vim.lsp.enable("lua_ls")
  vim.lsp.enable("mesonlsp")
  vim.lsp.config("nixd", {
    settings = {
      nixd = {
        formatting = { command = { "nixfmt" } },
      },
    },
  })
  vim.lsp.enable("nixd")
  vim.lsp.config("pyright", {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          typeCheckingMode = "off",
          useLibraryCodeForTypes = true,
        },
      },
    },
  })
  vim.lsp.enable("pyright")
  vim.lsp.enable("rust_analyzer")
  vim.lsp.enable("ts_ls")
  vim.lsp.enable("volar")
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
    signs = {
      text = {
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.WARN] = " ",
      },
    },
  })

  local util_custom = {
    find_git_ancestor = function(startpath)
      local dot_git = vim.fs.find(".git", { path = startpath, upward = true })[1]
      return dot_git and vim.fs.dirname(dot_git) or nil
    end,
  }
  local find_repo_root = function(startpath)
    local repo = vim.fs.find(".repo", { path = startpath, upward = true })[1]
    return repo and vim.fs.dirname(repo) or nil
  end
  local filepath = vim.fn.expand("%:p")
  local root_dir = find_repo_root(filepath) or util_custom.find_git_ancestor(filepath)
  if not root_dir then
    if #vim.api.nvim_list_uis() > 0 then
      -- vim.notify("No .repo or Git root directory found!", vim.log.levels.WARN)
    end
  else
    _G.root_dir = root_dir -- Make it globally accessible for server configs
  end

  -- show diagnostics when InsertLeave
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "rust", "nix", "haskell", "cpp", "c" },
    callback = function(args)
      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        buffer = args.buf,
        callback = function()
          vim.diagnostic.hide()
        end,
      })
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
        buffer = args.buf,
        callback = function()
          vim.diagnostic.show()
        end,
      })
    end,
  })

  _G.toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rust", "go", "nix" },
    callback = function()
      vim.api.nvim_buf_create_user_command(0, "InlayHintsToggle", _G.toggle_inlay_hints, {})
    end,
  })

  -- Function to manually generate .clangd file
  _G.gen_clangd_config = function()
    -- Reuse existing root_dir logic, find root if not available
    local filepath = vim.fn.expand("%:p")
    local root = _G.root_dir or find_repo_root(filepath) or util_custom.find_git_ancestor(filepath)

    if not root then
      vim.notify("Project root directory (.git or .repo) not found!", vim.log.levels.ERROR)
      return
    end

    local path = root .. "/.clangd"
    local content = {
      "CompileFlags:",
      "  Add: [",
      -- Disable compiler extensions, to enforce standard C/C++
      '    "-pedantic-errors",',
      -- Increasing warning levels
      '    "-Wall",',
      '    "-Weffc++",',
      '    "-Wextra",',
      '    "-Wconversion",',
      '    "-Wsign-conversion",',
      -- Treat warnings as errors
      '    "-Werror",',
      '    "-std=c++20"',
      "  ]",
    }

    -- If file exists, ask for confirmation to overwrite
    if vim.fn.filereadable(path) == 1 then
      local choice = vim.fn.confirm(".clangd already exists. Overwrite?", "&Yes\n&No", 2)
      if choice ~= 1 then
        return
      end
    end

    vim.fn.writefile(content, path)
    vim.notify("Generated .clangd in " .. root, vim.log.levels.INFO)

    -- Restart clangd to apply changes
    vim.cmd("LspRestart clangd")
  end

  -- Register command :GenClangdConfig
  vim.api.nvim_create_user_command(
    "GenClangdConfig",
    _G.gen_clangd_config,
    { desc = "Manually generate .clangd configuration file" }
  )
end
-- }}}
