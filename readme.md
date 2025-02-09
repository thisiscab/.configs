- `git clone git@github.com/thisiscab/.configs`

**On admin user**

- `sh ./setup_sudo.sh`

**On regular user**

- `sh ./setup_user.sh`

## Vim

- `vim`
- `:PackerInstall`

## Lang-servers

[server configurations docs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

- Python: `npm i -g pyright`
- Typescript: `npm i -g typescript-language-server`
- bash: `npm i -g bash-language-server`
- css: `npm i -g vscode-langservers-extracted`
- dockerfile: `npm i -g dockerfile-language-server-nodejs`
- yml: `npm i -g yaml-language-server`
- json: `npm i -g vscode-langservers-extracted`
- vim: `npm i -g vim-language-server`
- html: `npm i -g vscode-langservers-extracted`
- terraform: `brew install hashicorp/tap/terraform-ls`
- lua: `brew install lua-language-server`
- all: `brew install lua-language-server hashicorp/tap/terraform-ls && npm i -g pyright typescript-language-server bash-language-server vscode-langservers-extracted dockerfile-language-server-nodejs yaml-language-server vscode-langservers-extracted vim-language-server vscode-langservers-extracted`

## Formatter

- lua: luarocks install --server=https://luarocks.org/dev luaformatter
- prettier: npm install -g prettier
- Other installed through brew


