vim.pack.add({ "https://github.com/hiphish/rainbow-delimiters.nvim" }, { load = false })

require("lz.n").load({ "rainbow-delimiters.nvim", after = function() end, event = { "BufRead", "BufNewFile" } })
