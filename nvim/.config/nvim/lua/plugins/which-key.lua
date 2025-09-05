return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			local wk = require("which-key")
			wk.setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = true,
						suggestions = 20,
					},
				},
				icons = {
					breadcrumb = "",
					separator = "",
					group = "",
					ellipsis = "",
					-- set to false to disable all mapping icons,
					-- both those explicitly added in a mapping
					-- and those from rules
					mappings = false,
					--- Set to `false` to disable keymap icons from rules
					rules = false,
					-- use the highlights from mini.icons
					-- When `false`, it will use `WhichKeyIcon` instead
					colors = false,
					-- used by key format - disable all special key icons
					keys = {
						Up = "Up",
						Down = "Down",
						Left = "Left",
						Right = "Right",
						C = "C-",
						M = "M-",
						D = "D-",
						S = "S-",
						CR = "CR",
						Esc = "Esc",
						ScrollWheelDown = "ScrollDown",
						ScrollWheelUp = "ScrollUp",
						NL = "NL",
						BS = "BS",
						Space = "Space",
						Tab = "Tab",
						F1 = "F1",
						F2 = "F2",
						F3 = "F3",
						F4 = "F4",
						F5 = "F5",
						F6 = "F6",
						F7 = "F7",
						F8 = "F8",
						F9 = "F9",
						F10 = "F10",
						F11 = "F11",
						F12 = "F12",
					},
				},
				win = {
					border = "rounded",
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "left",
				},
				spec = {
					-- Find/Files
					{ "<leader>f", group = "Find/Files" },
					{ "<leader>ff", "<cmd>Neoformat<cr>", desc = "Format" },
					{ "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },

					-- Search
					{ "<leader>s", group = "Search" },
					{ "<leader>sr", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
					{ "<leader>sl", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
					{ "<leader>sf", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
					{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
					{ "<leader>ss", "vip:sort u<cr>", desc = "Sort Paragraph" },
					{ "<leader>sS", "vip:sort! u<cr>", desc = "Sort Paragraph (Reverse)" },

					-- Git
					{ "<leader>g", group = "Git" },
					{ "<leader>gs", "<cmd>Git<cr>", desc = "Status" },
					{ "<leader>gd", "<cmd>Gdiff<cr>", desc = "Diff" },
					{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
					{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
					{ "<leader>gl", "<cmd>Gclog<cr>", desc = "Log" },
					{ "<leader>gw", "<cmd>Gbrowse<cr>", desc = "Browse" },
					{ "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },

					-- LSP/Terminal
					{ "<leader>t", group = "LSP/Terminal" },
					{ "<leader>td", vim.lsp.buf.definition, desc = "Go to Definition" },
					{ "<leader>tl", vim.lsp.buf.type_definition, desc = "Type Definition" },
					{ "<leader>ti", vim.lsp.buf.implementation, desc = "Implementation" },
					{ "<leader>th", vim.lsp.buf.hover, desc = "Hover" },
					{ "<leader>te", vim.diagnostic.open_float, desc = "Show Diagnostic" },
					{ "<leader>ta", vim.lsp.buf.code_action, desc = "Code Action" },
					{ "<leader>tr", vim.lsp.buf.references, desc = "References" },
					{ "<leader>ts", vim.lsp.buf.signature_help, desc = "Signature Help" },

					-- Build/Tasks & Buffers
					{ "<leader>b", group = "Build/Tasks & Buffers" },
					{ "<leader>bb", "<cmd>OverseerToggle<cr>", desc = "Toggle Task Runner" },
					{ "<leader>br", "<cmd>OverseerRun<cr>", desc = "Run Task" },
					{ "<leader>ba", "<cmd>OverseerTaskAction<cr>", desc = "Task Actions" },
					{ "<leader>bc", "<cmd>OverseerClearCache<cr>", desc = "Clear Task Cache" },
					{ "<leader>bo", "<cmd>OverseerToggle<cr>", desc = "Toggle Output Panel" },
					{ "<leader>bq", "<cmd>bp <BAR> bd #<cr>", desc = "Close Buffer" },

					-- Replace/Reload
					{ "<leader>r", group = "Replace/Reload" },
					{ "<leader>rt", group = "Remove Trailing" },
					{ "<leader>rtw", ":%s/\\s\\+$//e<cr>", desc = "Remove Trailing Whitespace" },
					{ "<leader>rr", vim.lsp.buf.rename, desc = "Rename Symbol" },

					-- Misc
					{ "<leader>m", group = "Misc" },
					{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },

					-- Buffer Navigation
					{ "<leader>k", "<cmd>bnext<cr>", desc = "Next Buffer" },
					{ "<leader>j", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
					{ "<leader>l", "<cmd>b#<cr>", desc = "Last Buffer" },

					-- Utility
					{ "<leader>d", vim.diagnostic.open_float, desc = "Show Diagnostics" },
					{ "<leader>q", vim.diagnostic.setloclist, desc = "Diagnostic List" },
					{ "<leader>cs", "<cmd>noh<cr>", desc = "Clear Search" },
					{ "<leader>pwd", '<cmd>echo expand("%:p")<cr>', desc = "Show Path" },
					{ "<leader>snr", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", desc = "Search & Replace" },

					-- Visual mode sort
					{ "<leader>s", group = "Sort", mode = "v" },
					{ "<leader>ss", ":sort u<cr>", desc = "Sort", mode = "v" },
					{ "<leader>sS", ":sort! u<cr>", desc = "Sort (Reverse)", mode = "v" },

					-- Diagnostic navigation
					{ "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
					{ "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
				},
			})
		end,
	},
}

