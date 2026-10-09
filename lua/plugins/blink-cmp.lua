local a = "https://github.com/saghen/"
vim.pack.add(
  { "https://github.com/Kaiser-Yang/blink-cmp-avante", a .. "blink.lib", a .. "blink.cmp" },
  { load = false }
)

require("lz.n").load({
  "blink.cmp",
  after = function()
    local cmp = require("blink.cmp")
    cmp.build():wait(60000)
    require("blink-cmp").setup({
      appearance = {
        kind_icons = {
          Class = "",
          Cmdline = "",
          Color = "",
          Constant = "",
          Constructor = "",
          Enum = "",
          EnumMember = "",
          Event = "",
          Field = "",
          File = "",
          Folder = "",
          Function = "󰡱",
          Interface = "",
          Keyword = "",
          Method = "",
          Module = "󰕳",
          Operator = "",
          Property = "",
          Reference = "",
          Snippet = "",
          Struct = "",
          Text = "󰊄",
          TypeParameter = "",
          Unit = "",
          Value = "",
          Variable = "󱀍",
        },
        nerd_font_variant = "normal",
      },
      cmdline = {
        completion = {
          ghost_text = { enabled = false },
          list = { selection = { auto_insert = true, preselect = false } },
          menu = { auto_show = true },
        },
        enabled = true,
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
          update_delay_ms = 50,
          window = {
            border = "rounded",
            winblend = 0,
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
          },
        },
        ghost_text = { enabled = false },
        keyword = { range = "full" },
        list = {
          cycle = { from_bottom = true, from_top = true },
          selection = { auto_insert = true, preselect = false },
        },
        menu = {
          auto_show = true,
          border = "rounded",
          draw = {
            align_to = "label",
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
            components = {
              kind = {
                ellipsis = false,
                highlight = function(ctx)
                  return ctx.kind_hl
                end,
                text = function(ctx)
                  return ctx.kind
                end,
                width = { fill = true },
              },
              kind_icon = {
                ellipsis = false,
                highlight = function(ctx)
                  return ctx.kind_hl
                end,
                text = function(ctx)
                  return ctx.kind_icon .. ctx.icon_gap
                end,
              },
              label = {
                highlight = function(ctx)
                  local highlights = {
                    {
                      0,
                      #ctx.label,
                      group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                    },
                  }
                  if ctx.label_detail then
                    table.insert(highlights, {
                      #ctx.label,
                      #ctx.label + #ctx.label_detail,
                      group = "BlinkCmpLabelDetail",
                    })
                  end

                  -- characters matched on the label by the fuzzy matcher
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  return highlights
                end,
                text = function(ctx)
                  return ctx.label .. ctx.label_detail
                end,
                width = { fill = true, max = 60 },
              },
              label_description = {
                highlight = "BlinkCmpLabelDescription",
                text = function(ctx)
                  return ctx.label_description
                end,
                width = { max = 30 },
              },
              source_name = {
                highlight = "BlinkCmpSource",
                text = function(ctx)
                  return ctx.source_name
                end,
                width = { fill = true, max = 30 },
              },
            },
            gap = 1,
            padding = 0,
            treesitter = { "lsp" },
          },
          enabled = true,
          winblend = 0,
          winhighlight = "Normal:_BlinkCmpMenu,FloatBorder:_BlinkCmpMenuBorder,CursorLine:_BlinkCmpMenuSelection,Search:None",
        },
        trigger = {
          prefetch_on_insert = false,
          show_in_snippet = true,
          show_on_accept_on_trigger_character = true,
          show_on_blocked_trigger_characters = { " ", "\n", "\t" },
          show_on_insert_on_trigger_character = true,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_x_blocked_trigger_characters = { "'", '"', "(" },
        },
      },
      fuzzy = { implementation = "rust" },
      keymap = {
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<c-.>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.cancel()
            else
              cmp.show()
            end
          end,
        },
        ["<c-d>"] = { "scroll_documentation_down", "fallback" },
        ["<c-u>"] = { "scroll_documentation_up", "fallback" },
        ["<cr>"] = { "accept", "fallback" },
        preset = "none",
      },
      signature = {
        enabled = true,
        trigger = { show_on_insert_on_trigger_character = true },
        window = {
          border = "double",
          show_documentation = true,
          treesitter_highlighting = true,
          winblend = 0,
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "cmdline",
          "buffer",
          "dadbod",
          -- "dictionary",
        },
        providers = {
          cmdline = {
            enabled = function()
              return vim.api.nvim_get_mode().mode == "c" and vim.fn.getcmdtype() == ":"
            end,
            module = "blink.cmp.sources.cmdline",
            name = "cmdline",
            score_offset = 5,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Cmdline"
              for _, item in ipairs(items) do
                item.kind = kind_idx
                item.source_name = "Cmdline"
              end
              return items
            end,
          },
          dadbod = { module = "vim_dadbod_completion.blink", name = "Dadbod", score_offset = -3 },
          -- dictionary = {
          --   min_keyword_length = 3,
          --   module = "blink-cmp-dictionary",
          --   name = "Dict",
          --   opts = {
          --     dictionary_files = {
          --       -- "/nix/store/0saf31qid0bx1g7f1sidjp9lap2mfhxg-scowl-2020.12.07/share/dict/wamerican.60",
          --     },
          --   },
          --   score_offset = -3,
          -- },
          lsp = { score_offset = 5 },
          snippets = {
            opts = {
              extended_filetypes = { markdown = { "jekyll" }, sh = { "shelldoc" } },
              friendly_snippets = true,
            },
            score_offset = 4,
          },
        },
      },
      term = {
        completion = { ghost_text = { enabled = false }, menu = { auto_show = true } },
        enabled = true,
      },
    })
  end,
  before = function()
    local lzn = require("lz.n")
    lzn.trigger_load({
      "vim-dadbod-completion",
    })
  end,
  event = { "InsertEnter", "CmdlineEnter" },
})
