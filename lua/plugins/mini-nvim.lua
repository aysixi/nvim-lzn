vim.pack.add({ "https://github.com/nvim-mini/mini.completion" })
-- 假设你已经 require("lz.n") 并得到了一个简写，比如 local lzn = require("lz.n")
-- 或者直接调用 require("lz.n").load()

require("lz.n").load({
  "mini.completion",
  -- 优化性能：仅在进入插入模式（开始打字）时才加载补全插件
  event = { "InsertEnter" },

  -- 当插件加载后执行的函数
  after = function()
    require("mini.completion").setup({
      -- 将你的自定义配置放在这里
      delay = { completion = 100, info = 100, signature = 50 },

      window = {
        info = { height = 25, width = 80, border = nil },
        signature = { height = 25, width = 80, border = nil },
      },

      lsp_completion = {
        source_func = "completefunc",
        auto_setup = true,
      },

      fallback_action = "<C-n>",

      mappings = {
        force_twostep = "<C-Space>",
        force_fallback = "<A-Space>",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
      },
    })
  end,
})
