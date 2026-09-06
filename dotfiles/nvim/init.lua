-- =============================================================================
-- Options
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true -- show absolute line number on current line
vim.opt.signcolumn = "yes" -- always show; prevents layout shift on diagnostics
vim.opt.cursorline = true -- highlight the line the cursor is on
vim.opt.termguicolors = true -- enable 24-bit colour (required by most themes/plugins)
vim.opt.splitright = true -- vertical splits open to the right
vim.opt.splitbelow = true -- horizontal splits open below
vim.opt.undofile = true -- persist undo history across sessions
vim.opt.ignorecase = true -- case-insensitive search by default
vim.opt.smartcase = true -- override ignorecase when query contains uppercase
vim.opt.expandtab = true -- insert spaces instead of tab characters
vim.opt.shiftwidth = 2 -- spaces per indent level
vim.opt.tabstop = 2 -- visual width of a tab character
vim.opt.scrolloff = 8 -- keep 8 lines visible above/below cursor
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.updatetime = 250 -- faster CursorHold (used by gitsigns)

-- ui2: experimental redesign of messages/cmdline UI — no "Press ENTER", cmdline highlighting
require("vim._core.ui2").enable({})

vim.o.winborder = "rounded" -- bordered floats for LSP hover, diagnostics, etc.
vim.diagnostic.config({ float = { border = "rounded" } })

local map = vim.keymap.set
local augroup = vim.api.nvim_create_augroup

local function keymap(mode, lhs, rhs, desc, opts)
	opts = opts or {}
	opts.desc = desc
	map(mode, lhs, rhs, opts)
end

local function nmap(lhs, rhs, desc, opts)
	keymap("n", lhs, rhs, desc, opts)
end

local function leader(lhs, rhs, desc, opts)
	nmap("<leader>" .. lhs, rhs, desc, opts)
end

local groups = {
	pack = augroup("UserPack", { clear = true }),
	treesitter = augroup("UserTreesitter", { clear = true }),
	lint = augroup("UserLint", { clear = true }),
	autotag = augroup("UserAutotag", { clear = true }),
	diagnostics = augroup("UserDiagnostics", { clear = true }),
	lsp = augroup("UserLsp", { clear = true }),
}

-- =============================================================================
-- Plugins
-- =============================================================================

-- Build hooks must be registered before vim.pack.add so they fire on install
vim.api.nvim_create_autocmd("PackChanged", {
	group = groups.pack,
	callback = function(ev)
		if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
			return
		end
		local name = ev.data.spec.name
		-- Both nvim-treesitter and telescope-fzf-native require a `make` build step
		if name == "nvim-treesitter" or name == "telescope-fzf-native.nvim" then
			vim.system({ "make" }, { cwd = ev.data.path })
		end
	end,
})

local plugins = {
	"https://github.com/AlexvZyl/nordic.nvim",
	"https://github.com/NeogitOrg/neogit",
	"https://github.com/Saghen/blink.cmp",
	"https://github.com/Saghen/blink.lib",
	"https://github.com/WTFox/jellybeans.nvim",
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/folke/persistence.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/folke/ts-comments.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/gigacrat/aperture.nvim",
	"https://github.com/lewis6991/gitsigns.nvim", -- gutter signs + hunk operations
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/nicholascross/displace.nvim",
	"https://github.com/nvim-lua/plenary.nvim", -- required by telescope + neogit
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim", -- compiled fzf sorter for telescope
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/rmehri01/onenord.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim", -- edit filesystem as a buffer
	"https://github.com/windwp/nvim-ts-autotag",
}

-- vim.pack stores plugins in pack/core/opt/ — packadd each one so require() calls below work
vim.pack.add(plugins)
for _, plugin in ipairs(plugins) do
	local url = type(plugin) == "table" and plugin.src or plugin
	vim.cmd("packadd " .. url:match("([^/]+)$"))
end

-- =============================================================================
-- LSP
-- =============================================================================

local js_workspace_markers = {
	"pnpm-workspace.yaml",
	"pnpm-lock.yaml",
	"yarn.lock",
	"package-lock.json",
	"bun.lock",
	"bun.lockb",
	"turbo.json",
	"nx.json",
	"rush.json",
	"lerna.json",
}

local typescript_bin_cache = {}

local function typescript_supports_lsp(bin)
	if vim.fn.executable(bin) ~= 1 then
		return false
	end

	local out = vim.system({ bin, "--version" }, { text = true }):wait()
	local version = vim.version.parse(out.stdout or "")
	return out.code == 0 and version ~= nil and version.major >= 7
end

vim.lsp.config("tsc", {
	cmd = function(dispatchers, config)
		local cmd = typescript_bin_cache[(config or {}).root_dir] or "tsc"
		return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
	end,
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_dir = function(bufnr, on_dir)
		local root_markers = vim.deepcopy(js_workspace_markers)
		root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
			or vim.list_extend(root_markers, { ".git" })

		local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
		local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
		local project_root = vim.fs.root(bufnr, root_markers)
		if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
			return
		end
		if deno_root and (not project_root or #deno_root >= #project_root) then
			return
		end

		local root = project_root or vim.fn.getcwd()
		if typescript_bin_cache[root] then
			return on_dir(root)
		end

		for _, bin in ipairs({
			vim.fs.joinpath(root, "node_modules/.bin/tsc"),
			vim.fs.joinpath(root, "node_modules/.bin/tsgo"),
			"tsc",
			"tsgo",
		}) do
			if typescript_supports_lsp(bin) then
				typescript_bin_cache[root] = bin
				return on_dir(root)
			end
		end

		vim.notify("tsc: no binary supporting `--lsp` found (requires TypeScript 7.0+)", vim.log.levels.WARN)
	end,
	settings = {
		["js/ts"] = {
			inlayHints = {
				parameterNames = { enabled = "literals", suppressWhenArgumentMatchesName = true },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
	},
})

vim.lsp.config("eslint", {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_markers = vim.list_extend({
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.cjs",
		"eslint.config.js",
		"eslint.config.mjs",
	}, vim.list_extend(vim.deepcopy(js_workspace_markers), { "package.json", ".git" })),
	settings = {
		workingDirectory = { mode = "location" },
	},
	on_init = function(client)
		-- eslint uses push diagnostics (publishDiagnostics); clearing diagnosticProvider
		-- prevents nvim from sending pull requests that eslint can't handle
		client.server_capabilities.diagnosticProvider = nil
	end,
})

vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "typescriptreact", "javascriptreact", "html", "css" },
	root_markers = vim.list_extend(
		{ "tailwind.config.js", "tailwind.config.ts" },
		vim.list_extend(vim.deepcopy(js_workspace_markers), { "package.json", ".git" })
	),
})

vim.lsp.config("sqls", {
	cmd = { "sqls" },
	filetypes = { "sql" },
	root_markers = { ".git" },
})

vim.lsp.config("nil_ls", {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" }, -- neovim uses LuaJIT
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true), -- index neovim runtime
			},
			diagnostics = { globals = { "vim" } }, -- suppress "undefined global vim" warnings
		},
	},
})

vim.lsp.config("gleam", {
	cmd = { "gleam", "lsp" },
	filetypes = { "gleam" },
	root_markers = { "gleam.toml", ".git" },
})

vim.lsp.config("roc_ls", {
	cmd = { "roc_ls" },
	filetypes = { "roc" },
	root_markers = { ".git" },
})

vim.lsp.enable({ "tsc", "eslint", "tailwindcss", "sqls", "nil_ls", "lua_ls", "gleam", "roc_ls" })

vim.api.nvim_create_user_command("UserLspClients", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("No LSP clients attached to current buffer")
		return
	end

	for _, client in ipairs(clients) do
		local cmd = type(client.config.cmd) == "table" and table.concat(client.config.cmd, " ") or "<function>"
		print(("%s | root: %s | cmd: %s"):format(client.name, client.config.root_dir or "(none)", cmd))
	end
end, { desc = "Show LSP clients attached to the current buffer" })

vim.api.nvim_create_user_command("UserConfigReload", function()
	local config_path = vim.env.MYVIMRC or vim.fs.joinpath(vim.fn.stdpath("config"), "init.lua")
	local ok, err = pcall(dofile, config_path)
	if ok then
		print("Reloaded " .. config_path)
	else
		vim.notify("Config reload failed: " .. err, vim.log.levels.ERROR)
	end
end, { desc = "Reload Neovim config" })

-- =============================================================================
-- Plugin configuration
-- =============================================================================

-- Colorscheme
require("jellybeans").setup({})
require("nordic").setup({})
require("onenord").setup({})
require("tokyonight").setup({})

vim.cmd("colorscheme tokyonight")

-- Treesitter
-- nvim-treesitter v1.x removed the configs module; highlighting is via built-in vim.treesitter.
-- Install parsers once with :TSInstall typescript tsx javascript css html sql lua nix roc
vim.api.nvim_create_autocmd("FileType", {
	group = groups.treesitter,
	pattern = "*",
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf) -- pcall: silently skip if parser not yet installed
	end,
})

vim.filetype.add({ extension = { roc = "roc" } })

-- blink.cmp — LSP, path, buffer sources only; snippets excluded
local cmp = require("blink.cmp")
-- cmp.build():pwait()
cmp.setup({
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	keymap = {
		preset = "default",
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		-- Accept with CR while letting mini.pairs handle it when menu is closed
		["<CR>"] = {
			function(cmp)
				if cmp.is_visible() then
					return cmp.accept()
				end
			end,
			"fallback",
		},
	},
	completion = {
		menu = { border = "rounded" },
		documentation = { window = { border = "rounded" } },
	},
	signature = {
		enabled = true,
	},
})

-- Telescope + fzf-native
require("telescope").setup({
	defaults = {
		path_display = { "truncate" },
	},
})
require("telescope").load_extension("fzf")

-- Oil
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})

-- Gitsigns
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function bmap(mode, lhs, rhs, desc)
			map(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end
		bmap("n", "]h", function()
			gs.nav_hunk("next")
		end, "Next hunk")
		bmap("n", "[h", function()
			gs.nav_hunk("prev")
		end, "Prev hunk")
		bmap("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
		bmap("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
		bmap("n", "<leader>hb", gs.blame_line, "Blame line")
	end,
})

-- Neogit
require("neogit").setup({})

-- persistence.nvim — auto-saves and restores sessions per directory
require("persistence").setup()

-- mini.pairs — auto-close brackets, quotes, etc.
require("mini.pairs").setup()

-- which-key — shows popup of available keymaps after pressing a prefix
local wk = require("which-key")
wk.setup()
wk.add({
	{ "<leader>b", group = "Buffer" },
	{ "<leader>f", group = "Find" },
	{ "<leader>g", group = "Git" },
	{ "<leader>h", group = "Git hunk" },
	{ "<leader>j", group = "Jump" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>s", group = "Session" },
	{ "<leader>w", group = "Window" },
	{ "<leader>x", group = "Trouble" },
})

-- trouble.nvim — pretty list for diagnostics, references, quickfix, location list
require("trouble").setup()

-- nvim-lint — sqlfluff for SQL (all other filetypes are covered by LSPs)
local lint = require("lint")
lint.linters_by_ft = { sql = { "sqlfluff" } }
lint.linters.sqlfluff.args = { "lint", "--format", "json", "--dialect", "postgres" }
vim.api.nvim_create_autocmd("BufWritePost", {
	group = groups.lint,
	callback = function()
		lint.try_lint()
	end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = groups.lint,
	callback = function()
		lint.try_lint()
	end,
})

-- conform.nvim — formatting with format-on-save
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		sql = { "sqlfluff" },
	},
	formatters = {
		sqlfluff = { args = { "format", "--dialect", "postgres", "-" }, require_cwd = false },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

-- todo-comments.nvim — highlight and search TODO/FIXME/HACK/NOTE etc.
require("todo-comments").setup()

-- ts-comments.nvim — extends built-in gcc/gc commenting with treesitter-aware comment strings
-- handles embedded languages correctly (e.g. JSX uses {/* */} not //)
require("ts-comments").setup()

-- nvim-ts-autotag — auto-close and auto-rename HTML/JSX tags via treesitter
-- Disable for pager buffers: they have no treesitter parser and nvim-ts-autotag
-- crashes on InsertLeave (nil parser) when it erroneously attaches to them
require("nvim-ts-autotag").setup()
-- nvim-ts-autotag doesn't nil-check the parser before indexing it, so it crashes
-- on InsertLeave for buffers without a treesitter parser (e.g. pager, help, qf).
-- vim.schedule defers until after all FileType handlers run, so we clear the
-- InsertLeave autocmd nvim-ts-autotag already registered for that buffer.
vim.api.nvim_create_autocmd("FileType", {
	group = groups.autotag,
	pattern = { "pager", "help", "qf", "nofile" },
	callback = function(ev)
		vim.schedule(function()
			vim.api.nvim_clear_autocmds({ event = "InsertLeave", buffer = ev.buf })
		end)
	end,
})

-- mini.surround — sa/sd/sr to add, delete, replace surroundings
require("mini.surround").setup()

-- flash.nvim — no setup needed beyond keymaps; defaults are fine
---@diagnostic disable-next-line: missing-fields
require("flash").setup({
	modes = {
		search = {
			enabled = true,
		},
	},
})

-- snacks.nvim
-- shows a floating menu instead of bottom menu
require("snacks").setup({
	picker = {
		ui_select = true,
	},
})

-- aperture.nvim
-- dims inactive windows
require("aperture").setup({
	autosize = {
		enabled = false,
	},
})

-- lualine
require("lualine").setup({})

-- displace
-- provides jump-to-window
require("displace").setup({})

-- =============================================================================
-- Keymaps
-- =============================================================================
local tel = require("telescope.builtin")

-- Telescope
leader("ff", tel.find_files, "Find files")
leader("fg", tel.live_grep, "Live grep")
leader("fb", tel.buffers, "Buffers")
leader("fs", tel.lsp_document_symbols, "Document symbols")
leader("fS", tel.lsp_workspace_symbols, "Workspace symbols")
leader("fd", tel.diagnostics, "Diagnostics")
leader("fk", tel.keymaps, "Keymaps")
leader("fc", tel.commands, "Commands")
leader("ft", "<cmd>TodoTelescope<cr>", "Todo comments")

-- Flash
keymap({ "n", "x", "o" }, "s", require("flash").jump, "Flash jump")

-- Oil
nmap("-", "<cmd>Oil<cr>", "Open parent directory")

-- Windows
leader("wh", "<C-w>s", "Split horizontal (<C-w>s)")
leader("wv", "<C-w>v", "Split vertical (<C-w>v)")

-- Jumps
leader("jb", "<C-o>", "Jump back (<C-o>)")
leader("jf", "<C-i>", "Jump forward (<C-i>)")
leader("jw", require("displace.navigator").show_window_numbers, "Jump to window")

-- Neogit
leader("gg", "<cmd>Neogit<cr>", "Open Neogit")

-- Diagnostics
nmap("]d", function()
	vim.diagnostic.jump({ count = 1 })
end, "Next diagnostic")

nmap("[d", function()
	vim.diagnostic.jump({ count = -1 })
end, "Prev diagnostic")

-- Persistence
leader("ss", require("persistence").load, "Restore session")

leader("sl", function()
	require("persistence").load({ last = true })
end, "Restore last session")

leader("sd", require("persistence").stop, "Don't save session")

-- Buffers
leader("bd", "<cmd>bdelete<cr>", "Delete buffer")

-- Trouble
leader("xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
leader("xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer diagnostics (Trouble)")
leader("xs", "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)")
leader("xl", "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>", "LSP definitions/refs (Trouble)")
leader("xq", "<cmd>Trouble qflist toggle<cr>", "Quickfix list (Trouble)")
leader("xL", "<cmd>Trouble loclist toggle<cr>", "Location list (Trouble)")

-- Terminal
keymap("t", "<Esc>", "<C-\\><C-N>", "Exit terminal mode")

-- LSP keymaps — only active when an LSP is attached to the buffer
vim.api.nvim_create_autocmd("CursorHold", {
	group = groups.diagnostics,
	callback = function()
		-- ui2 filetypes to ignore (cmdline, message, dialog, pager windows)
		local ui2_filetypes = { cmd = true, msg = true, dialog = true, pager = true }
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local config = vim.api.nvim_win_get_config(win)
			if config.relative ~= "" then
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.bo[buf].filetype
				if not ui2_filetypes[ft] then
					-- A non-ui2 floating window (hover, telescope, etc.) is open
					return
				end
			end
		end
		-- Only show diagnostics if there are actually diagnostics on this line
		local lnum = vim.fn.line(".") - 1
		if #vim.diagnostic.get(0, { lnum = lnum }) > 0 then
			vim.diagnostic.open_float(nil, { focus = false })
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = groups.lsp,
	callback = function(ev)
		local opts = { buffer = ev.buf }
		local function lsp_map(mode, lhs, rhs, desc)
			map(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
		end

		-- Muscle-memory LSP bindings.
		lsp_map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		lsp_map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		lsp_map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		lsp_map("n", "gr", tel.lsp_references, "References")
		lsp_map("n", "K", vim.lsp.buf.hover, "Hover docs")

		-- Which-key discoverable LSP actions.
		lsp_map("n", "<leader>ld", vim.lsp.buf.definition, "Definition (gd)")
		lsp_map("n", "<leader>lD", vim.lsp.buf.declaration, "Declaration (gD)")
		lsp_map("n", "<leader>li", vim.lsp.buf.implementation, "Implementation (gi)")
		lsp_map("n", "<leader>lr", tel.lsp_references, "References (gr)")
		lsp_map("n", "<leader>lh", vim.lsp.buf.hover, "Hover docs (K)")
		lsp_map("n", "<leader>ln", vim.lsp.buf.rename, "Rename symbol")
		lsp_map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code action")
		lsp_map("n", "<leader>lf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, "Format buffer")
	end,
})
