require('plugins')
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()
require("nvim-tree").setup()
require('monokai').setup {}
-- Map leaders are special keys that we can use when toggling other functionality in the keymapping section
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Mapping keys
-- n = normal mode
-- v = visual mode
-- i = interactive mode
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>')
vim.keymap.set({ 'n', 'v' }, '<Leader>s', ':w<CR>')
vim.keymap.set('n', '<Leader>f', ':LspZeroFormat<CR>')
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float)
vim.keymap.set({ 'n' }, '<Leader>.', vim.diagnostic.setloclist)
vim.keymap.set('n', '<Leader>p', ':Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>q', ':q<CR>')
vim.keymap.set('n', '<Leader>w', ':wq<CR>')
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '\\', ':nohl<CR>') -- cancel search so that nothing is highlighted anymore
vim.keymap.set('i', 'kk', '<ESC>') -- cancel search so that nothing is highlighted anymore


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

require 'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = { "c", "lua", "rust" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = { "c", "rust" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}

-- turn off backup copy so that trunk will work properly
vim.o.backupcopy = "no";
