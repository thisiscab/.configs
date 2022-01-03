set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <leader>cd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ci :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>csh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>crr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>crn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ch :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>csd :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>cn :lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap [d :lua vim.diagnostic.goto_prev()<CR>
nnoremap ]d :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>d :lua vim.diagnostic.setloclist()<CR>

lua <<EOF
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({

    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
    },

    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
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
        ["<S-Tab>"] = cmp.mapping(function(fallback)
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

require("luasnip.loaders.from_vscode").lazy_load()

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup{}
lspconfig.pyright.setup{}
lspconfig.bashls.setup{}
lspconfig.cssls.setup{}
lspconfig.dockerls.setup{}
lspconfig.yamlls.setup{}
lspconfig.jsonls.setup{}
lspconfig.vimls.setup{}
lspconfig.html.setup{}

EOF
