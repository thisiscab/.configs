local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local vimgrep_arguments = {unpack(telescopeConfig.values.vimgrep_arguments)}

local function multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabedit",
        default = "edit"
    }
    local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer"
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            local filename, row, col

            if entry.path or entry.filename then
                filename = entry.path or entry.filename

                row = entry.row or entry.lnum
                col = vim.F.if_nil(entry.col, 1)
            elseif not entry.bufnr then
                local value = entry.value
                if not value then return end

                if type(value) == "table" then
                    value = entry.display
                end

                local sections = vim.split(value, ":")

                filename = sections[1]
                row = tonumber(sections[2])
                col = tonumber(sections[3])
            end

            local entry_bufnr = entry.bufnr

            if entry_bufnr then
                if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                    vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                end
                local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api
                                                 .nvim_buf_get_name(entry_bufnr)))
            else
                local command = i == 1 and "edit" or edit_file_cmd_map[method]
                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = require("plenary.path"):new(vim.fn.fnameescape(
                                                               filename))
                                   :normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end
            end

            if row and col then
                pcall(vim.api.nvim_win_set_cursor, 0, {row, col - 1})
            end
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

local function multiopen_selection(prompt_bufnr)
    multiopen(prompt_bufnr, "default")
end

telescope.setup({
    defaults = {
        mappings = {
            i = {["<C-s>"] = "select_all"},
            n = {["<C-s>"] = "select_all"}

        },
        hidden = true,
        respect_gitignore = false,
        preview = false
    },
    pickers = {
        find_files = {
            -- mappings = {
            --     i = {
            --         ["<CR>"] = multiopen_selection,
            --     },
            -- },
            find_command = {
                "rg", "--files", "--hidden", "--glob", "!{**/.git,**/node_modules,**/.yarn,**/.postman,**/cli/bin}/*"
            }
        }
    },
    extensions = {
      -- cder = {
      --   dir_command = { 'fd', '--type=d', '.', os.getenv('HOME') .. "/src/work/chord" },
      -- },
        file_browser = {
            hidden = false,
            hijack_netrw = true,
            disable_devicons = true,
            mappings = {
                i = {
                    ["<C-r>"] = function(prompt_bufnr)
                    local git_root_path =
                        require("plenary.job"):new({ command = "git", args = { "rev-parse", "--show-toplevel" } }):sync()[1]
                    local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                    local finder = current_picker.finder
                     if finder.files then
                        require("telescope._extensions.file_browser.utils").redraw_border_title(
                            current_picker)
                        current_picker:refresh(finder, {
                            reset_prompt = true,
                            multi = current_picker._multi
                        })
                    else
                        finder.cwd = git_root_path
                    end
                    require("telescope._extensions.file_browser.utils").redraw_border_title(current_picker)
                    current_picker:refresh(finder, { reset_prompt = true, multi = current_picker._multi })
                    end
                }
            }
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({
                layout_config = {
                    prompt_position = "bottom",
                    width = 0.6,
                    height = 0.4,
                },
                -- Even more opts
            })
        }
    }
})

require("telescope").load_extension "file_browser"
require("telescope").load_extension "fzf"
require("telescope").load_extension "ui-select"
