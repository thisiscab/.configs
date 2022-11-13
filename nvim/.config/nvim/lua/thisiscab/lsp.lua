local Remap = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

Remap.nmap = bind("n", { noremap = false })
Remap.nnoremap = bind("n")
Remap.vnoremap = bind("v")
Remap.xnoremap = bind("x")
Remap.inoremap = bind("i")

local cmp = require("cmp")
local comp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
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

    experimental = {
        ghost_text = true,
    },

    mapping = {
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<TAB>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),

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

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "calc" },
        { name = "path" },
        { name = "buffer" },
    }),
})

cmp.setup.filetype({ "markdown", "text", "gitcommit" }, {
    sources = cmp.config.sources({
        { name = "emoji" },
    }),
})
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = comp.default_capabilities(),
        on_attach = function()
            nnoremap("<leader>td", function()
                vim.lsp.buf.definition()
            end)
            nnoremap("<leader>tl", function()
                vim.lsp.buf.type_definition()
            end)
            nnoremap("<leader>ti", function()
                vim.lsp.buf.implementation()
            end)
            nnoremap("<leader>th", function()
                vim.lsp.buf.hover()
            end)
            nnoremap("<leader>te", function()
                vim.diagnostic.open_float()
            end)
            nnoremap("[d", function()
                vim.diagnostic.goto_prev()
            end)
            nnoremap("]d", function()
                vim.diagnostic.goto_next()
            end)
            nnoremap("<leader>ta", function()
                vim.lsp.buf.code_action()
            end)
            nnoremap("<leader>tr", function()
                vim.lsp.buf.references()
            end)
            nnoremap("<leader>ts", function()
                vim.lsp.buf.signature_help()
            end)
            nnoremap("<leader>d", function()
                vim.diagnostic.setloclist()
            end)
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
lspconfig.terraformls.setup(config())

require("lspconfig").sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
require("luasnip.loaders.from_vscode").lazy_load()
