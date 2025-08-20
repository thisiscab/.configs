local g = vim.g
local opt = vim.opt
local o = vim.o
local keymap = vim.keymap

g.mapleader = " "

opt.clipboard = "unnamed"

opt.autoindent = true

opt.ignorecase = true
opt.infercase = true
opt.smartcase = true
opt.expandtab = true

opt.wrap = false
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.softtabstop = 2

opt.number = true
opt.relativenumber = true
vim.cmd('set iskeyword+=-')

-- opt.complete = vim.opt.complete .. "kspell"
-- o.completeopt = "menu,menuone,noselect"

vim.cmd('packadd packer.nvim')

local packer = require 'packer'

local util = require 'packer.util'

packer.init({
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function(use)
    use "wbthomason/packer.nvim"

    use "neovim/nvim-lspconfig"
    use "editorconfig/editorconfig-vim"

    use {

        "christoomey/vim-tmux-navigator",
        event = {"VimEnter"},
        config = function() require("thisiscab.tmux") end
    }

    use {
        "sainnhe/gruvbox-material",
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd("colorscheme gruvbox-material")
        end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end,
        config = function() require("thisiscab.treesitter") end
    }

    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter"
    })

    use {
        "hashivim/vim-terraform",
        ft = {"terraform"},
        config = function() require("thisiscab.terraform") end
    }

    use {
        "sbdchd/neoformat",
        cmd = {"Neoformat"},
        config = function() require("thisiscab.neoformat") end
    }

    use {
        "L3MON4D3/LuaSnip",
        requires = {"rafamadriz/friendly-snippets"},
        run = "make install_jsregexp"
    }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-calc", "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp",

            "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip"
        },
        config = function() require("thisiscab.lsp") end
    }

    use {"rafamadriz/friendly-snippets"}

    use {
        "nvim-telescope/telescope.nvim",
        event = {"VimEnter"},
        requires = {
            "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            'nvim-telescope/telescope-file-browser.nvim'
        },
        config = function() require("thisiscab.telescope") end
    }

    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- use {
    --     requires = {"nvim-telescope/telescope.nvim"},
    --     config = function() require("cder") end
    -- }

    -- use {
    --     "mattn/vim-gist",
    --     requires = {"mattn/webapi-vim"},
    --     config = function()
    --         vim.cmd([[
    --             let g:gist_clip_command = 'pbcopy'
    --             let g:gist_detect_filetype = 1
    --             let g:gist_post_private = 1
    --         ]])
    --     end
    --
    -- }

    use {
        "tpope/vim-fugitive",
        cmd = {"Git", "GBrowse", "GBlame"},
        requires = {"tpope/vim-rhubarb", "shumphrey/fugitive-gitlab.vim"}
    }

    use {"JoosepAlviste/nvim-ts-context-commentstring"}

    use {
        "terrortylor/nvim-comment",
        event = "BufReadPre",
        requires = {"JoosepAlviste/nvim-ts-context-commentstring"},
        config = function() require("thisiscab.comment") end
    }

    use {"fatih/vim-go", ft = {"go"}}

    -- use {"mpas/marp-nvim"}

    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        cmd = {"MarkdownPreviewToggle", "MarkdownPreview"},
        ft = {"markdown", "vim-plug"},
        config = function() require("thisiscab.markdown-preview") end
    }

    use {
        "supermaven-inc/supermaven-nvim",
        config = function() require("supermaven-nvim").setup({}) end
    }
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { 'MunifTanjim/eslint.nvim' }
end)

-- NeoFormat
keymap.set("n", "<leader>ff", ":Neoformat<CR>")

-- Telescope
keymap.set("n", "<Leader>sr", ":Telescope find_files<CR>")
keymap.set("n", "<Leader>sl", ":Telescope find_files<CR>")
keymap.set("n", "<Leader>sf", ":Telescope live_grep<CR>")
keymap.set("n", "<Leader>sb", ":Telescope buffers<CR>")
keymap.set("n", "<Leader>fb", ":Telescope file_browser<CR>")

-- cder
-- keymap.set("n", "<leader>cd", ":Telescope cder<CR>")

-- Fugitive
keymap.set("n", "<leader>gs", ":Git<CR>", {silent = true})
keymap.set("n", "<leader>gd", ":Gdiff<CR>", {silent = true})
keymap.set("n", "<leader>gc", ":Git commit<CR>", {silent = true})
keymap.set("n", "<leader>gb", ":Git blame<CR>", {silent = true})
keymap.set("n", "<leader>gl", ":Gclog<CR>", {silent = true})
keymap.set("n", "<leader>gw", ":Gbrowse<CR>", {silent = true})
keymap.set("n", "<leader>gp", ":Git push<CR>", {silent = true})

-- Markdown Preview
keymap.set("n", "<Leader>mp", ":MarkdownPreviewToggle<CR>")

-- Custom
keymap.set("n", "<Leader>rtw", ":%s/\\s\\+$//e<CR>")
keymap.set("n", "<Leader>snr", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
keymap.set("n", "<Leader>pwd", ':echo expand("%:p")<CR>')
keymap.set("n", "<Leader>cs", ":noh<CR>")

-- Buffer Navigation
keymap.set("n", "<Leader>k", ":bnext<CR>")
keymap.set("n", "<Leader>j", ":bprevious<CR>")
keymap.set("n", "<Leader>l", ":b#<CR>")
keymap.set("n", "<Leader>bq", ":bp <BAR> bd #<CR>")

-- I'm stupid
vim.cmd("command! WQ wq")
vim.cmd("command! Wq wq")
vim.cmd("command! W w")
vim.cmd("command! Q q")

-- Sorting
keymap.set("n", "<Leader>ss", "vip:sort u<CR>")
keymap.set("n", "<Leader>SS", "vip:sort! u<CR>")
keymap.set("v", "<Leader>ss", ":sort u<CR>")
keymap.set("v", "<Leader>SS", ":sort! u<CR>")

keymap.set("n", "<leader>rr", ":source $MYVIMRC<CR>")

keymap.set("n", "<leader>t", function()
    vim.cmd("cd %:p:h")
    vim.cmd("terminal")
    vim.cmd("startinsert")
end)

-- autocmd Syntax * syntax keyword GreenMarker NOTE note
-- autocmd Syntax * syntax keyword YellowMarker TODO todo
-- autocmd Syntax * syntax keyword RedMarker FIXME XXX fixme xxx
-- highlight GreenMarker cterm=reverse ctermfg=108 ctermbg=235 gui=bold guifg=#8ec07c guibg=#282828
-- highlight YellowMarker cterm=bold ctermfg=235 ctermbg=214 gui=bold guifg=#282828 guibg=#fabd2f
-- highlight RedMarker cterm=bold ctermfg=235 ctermbg=167 gui=bold guifg=#282828 guibg=#fb4934
