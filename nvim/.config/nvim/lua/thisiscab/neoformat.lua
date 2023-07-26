local g = vim.g


g.neoformat_basic_format_trim = 1
g.neoformat_basic_format_retab = 1
g.neoformat_basic_format_align = 0

g.neoformat_enabled_lua = {"luaformat"}

g.neoformat_enabled_markdown = {"prettier"}
g.neoformat_enabled_html = {"prettier"}
g.neoformat_enabled_javascript = {"prettier"}
g.neoformat_enabled_json = {"prettier"}
g.neoformat_enabled_ruby = {"prettier"}

g:neoformat_try_node_exe = 1
g.neoformat_enabled_typescript = {"eslint_d", "prettier"}
g.neoformat_enabled_vue = {"prettier"}
g.neoformat_enabled_yaml = {"prettier"}
g.neoformat_enabled_helm = {"prettier"}

g.neoformat_enabled_python = {"black"}

g.neoformat_enabled_shell = {"shfmt"}
g.neoformat_enabled_zsh = {"shfmt"}
g.shfmt_opt = "-ci"

g.neoformat_enabled_terraform = {"terraform"}
