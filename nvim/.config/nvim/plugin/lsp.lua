local Remap = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
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
local lspconfig = require('lspconfig')
local luasnip = require("luasnip")

local nnoremap = Remap.nnoremap

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({

    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
    },

    mapping = {
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<TAB>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),

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
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
        {
            { name = 'buffer' },
        }
    )
})


local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = comp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
        nnoremap("<leader>td", function() vim.lsp.buf.definition() end)
        nnoremap("<leader>tl", function() vim.lsp.buf.type_definition() end)
        nnoremap("<leader>ti", function() vim.lsp.buf.implementation() end)
        nnoremap("<leader>th", function() vim.lsp.buf.hover() end)
        nnoremap("<leader>te", function() vim.diagnostic.open_float() end)
        nnoremap("[d", function() vim.diagnostic.goto_prev() end)
        nnoremap("]d", function() vim.diagnostic.goto_next() end)
        nnoremap("<leader>ta", function() vim.lsp.buf.code_action() end)
        nnoremap("<leader>tr", function() vim.lsp.buf.references() end)
        nnoremap("<leader>ts", function() vim.lsp.buf.signature_help() end)
        nnoremap("<leader>d", function() vim.diagnostic.setloclist() end)
        end,
        }, _config or {})
end


lspconfig.tsserver.setup(config())
lspconfig.pyright.setup(config())
lspconfig.bashls.setup(config())
lspconfig.cssls.setup(config())
lspconfig.dockerls.setup(config())
lspconfig.yamlls.setup(config())
lspconfig.jsonls.setup(config())
lspconfig.vimls.setup(config())
lspconfig.html.setup(config())

require("luasnip.loaders.from_vscode").lazy_load()
