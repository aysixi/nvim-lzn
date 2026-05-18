vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

require("lualine").setup({
  options = { globalstatus = true, theme = "auto" },
  sections = {
    lualine_c = {
      {
        function()
          local ok, gb = pcall(require, "gitblame")
          if ok and gb.is_blame_text_available() then
            return gb.get_current_blame_text()
          end
          return ""
        end,
        fmt = function(str)
          if str == "" then
            return str
          end
          local limit = math.floor(vim.o.columns / 2)
          if #str > limit and limit > 2 then
            return string.sub(str, 1, limit - 2) .. "..."
          end
          return str
        end,
      },
    },
    lualine_x = {
      {
        function()
          local recording_register = vim.fn.reg_recording()
          if recording_register == "" then
            return ""
          else
            return "⏺  Recording @" .. recording_register
          end
        end,
        color = { fg = "#ff9e64" },
      },
      { "get_fcitx5_status()", color = { fg = "#7aa2f7" } },
      "encoding",
      "fileformat",
      "filetype",
    },
  },
})
