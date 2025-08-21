local Remap = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

Remap.nmap = bind("n", {noremap = false})
Remap.nnoremap = bind("n")
Remap.vnoremap = bind("v")
Remap.xnoremap = bind("x")
Remap.inoremap = bind("i")

local cmp = require("cmp")
local comp = require("cmp_nvim_lsp")
local configs = require('lspconfig.configs')
local lspconfig = require("lspconfig")
local util = require('lspconfig.util')
local luasnip = require("luasnip")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end
    },

    experimental = {ghost_text = true},

    mapping = {
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- ["<TAB>"] = cmp.mapping.confirm({select = true}),
        -- ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<C-j>"] = cmp.mapping.confirm({select = true}),
        ["<C-y>"] = cmp.mapping.confirm({select = true}),
        ['<C-e>'] = cmp.mapping.abort(),

        -- ["<Tab>"] = cmp.mapping(function() luasnip.expand_or_jump() end, {"i", "s"}),
        -- ["<S-Tab>"] = cmp.mapping(function() luasnip.jump(-1) end, {"i", "s"}),

        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, {"i", "s"})
    },

    sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "luasnip"}}, {
        {name = "calc"}, {name = "path"}, {name = "buffer"},  { name = "supermaven" }
    })
})

cmp.setup.filetype({"markdown", "text", "gitcommit"},
                   {sources = cmp.config.sources({{name = "emoji"}})})

cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        {name = "cmp_git"} -- You can specify the `cmp_git` source if you were installed it.
    }, {{name = "buffer"}})
})

-- Cmdline completion disabled due to regex parsing issues
-- cmp.setup.cmdline({"/", "?"}, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {{name = "buffer"}}
-- })
-- 
-- cmp.setup.cmdline(":", {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})
-- })

-- local function config(_config)
--     return vim.tbl_deep_extend("force", {
--         capabilities = comp.default_capabilities(),
--         on_attach = function(client, bufnr)
--             -- Enable completion triggered by <c-x><c-o>
--             vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--             vim.keymap.set('n', "<leader>td", function()
--                 vim.lsp.buf.definition()
--             end)
--             vim.keymap.set('n', "<leader>tl", function()
--                 vim.lsp.buf.type_definition()
--             end)
--             vim.keymap.set('n', "<leader>ti", function()
--                 vim.lsp.buf.implementation()
--             end)
--             vim.keymap.set('n', "<leader>th", function() vim.lsp.buf.hover() end)
--             vim.keymap.set('n', "<leader>te", function()
--                 vim.diagnostic.open_float()
--             end)
--             vim.keymap.set('n', "[d", function() vim.diagnostic.goto_prev() end)
--             vim.keymap.set('n', "]d", function() vim.diagnostic.goto_next() end)
--             vim.keymap.set('n', "<leader>ta", function()
--                 vim.lsp.buf.code_action()
--             end)
--             vim.keymap.set('n', "<leader>tr", function()
--                 vim.lsp.buf.references()
--             end)
--             vim.keymap.set('n', "<leader>ts", function()
--                 vim.lsp.buf.signature_help()
--             end)
--             vim.keymap.set('n', "<leader>d", function()
--                 vim.diagnostic.setloclist()
--             end)
--         end
--     }, _config or {})
-- end

local opts = {noremap = true, silent = true}
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', "<leader>td", vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', "<leader>tl", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', "<leader>ti", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', "<leader>th", vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', "<leader>te", vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', "[d", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', "]d", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', "<leader>ta", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', "<leader>tr", vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', "<leader>ts", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', "<leader>rr", vim.lsp.buf.rename, bufopts)
end

-- ESLint is now handled by nvim-lint and conform.nvim

-- if not configs.dbtls then
--     configs.dbtls = {
--         default_config = {
--             root_dir = lspconfig.util.root_pattern('dbt_project.yml'),
--             cmd = { 'dbt-language-server', '--stdio' },
--             filetypes = { "sql" },
--             init_options = { pythonInfo = { path = 'python' }, lspMode = 'dbtProject', enableSnowflakeSyntaxCheck = true }
--         },
--     }
-- end
--
-- lspconfig.dbtls.setup{}

-- Set up Mason LSP config
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_lspconfig_ok then
  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = comp.default_capabilities(),
      })
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = comp.default_capabilities(),
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
    ["ts_ls"] = function()
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = comp.default_capabilities(),
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
      })
    end,
  })
end

if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = {"helm_ls", "serve"},
      filetypes = {'helm'},
      root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
      end,
    },
  }
end

vim.diagnostic.config({
  virtual_text = false
})

-- require("lspconfig").sumneko_lua.setup({
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = "LuaJIT"
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {"vim"}
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = vim.api.nvim_get_runtime_file("", true),
--                 checkThirdParty = false
--             },
--             -- Do not send telemetry data containing a randomized but unique identifier
--             telemetry = {enable = false}
--         }
--     }
-- })
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("typescriptreact", { "html", "javascriptreact" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end
  end,
})
