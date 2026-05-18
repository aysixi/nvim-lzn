vim.g.node_host_prog = "/nix/store/bdh31g051f55icgvz08dwsyqqqp5nfmp-node-client-5.4.0/bin/neovim-node-host"
vim.g.perl_host_prog = "/nix/store/5a9ynp3kr57dfc8ir9nacjiyv2anqlgq-perl-5.42.0-env/bin/perl"
vim.g.ruby_host_prog = "/nix/store/dpgbk2cb4h6adwjg6rp9xc84jkxsyq8s-neovim-ruby-env/bin/neovim-ruby-host"
vim.g.python3_host_prog = "/nix/store/hdmgm9vlgbq6fmy1g55cvcn3nvzbgjlk-nvim-host-python3-3.13.12-env/bin/nvim-python3"
-- require("vim._core.ui2").enable()
vim.pack.add({ { src = "https://github.com/lumen-oss/lz.n" } })
require("plugins")

require("base.options")
require("base.keymaps")
require("base.fcitx5")
require("base.extraConfigLua")
require("base.autocmd")
