-- =============================================================================
-- Options
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true                -- show absolute line number on current line
vim.opt.signcolumn = "yes"           -- always show; prevents layout shift on diagnostics
vim.opt.cursorline = true            -- highlight the line the cursor is on
vim.opt.termguicolors = true         -- enable 24-bit colour (required by most themes/plugins)
vim.opt.splitright = true            -- vertical splits open to the right
vim.opt.splitbelow = true            -- horizontal splits open below
vim.opt.undofile = true              -- persist undo history across sessions
vim.opt.ignorecase = true            -- case-insensitive search by default
vim.opt.smartcase = true             -- override ignorecase when query contains uppercase
vim.opt.expandtab = true             -- insert spaces instead of tab characters
vim.opt.shiftwidth = 2               -- spaces per indent level
vim.opt.tabstop = 2                  -- visual width of a tab character
vim.opt.scrolloff = 8                -- keep 8 lines visible above/below cursor
vim.opt.clipboard = "unnamedplus"    -- sync with system clipboard
vim.opt.updatetime = 250             -- faster CursorHold (used by gitsigns)

-- ui2: experimental redesign of messages/cmdline UI — no "Press ENTER", cmdline highlighting
require("vim._core.ui2").enable({})

vim.o.winborder = "rounded"          -- bordered floats for LSP hover, diagnostics, etc.
vim.diagnostic.config({ float = { border = "rounded" } })

-- =============================================================================
-- Plugins
-- =============================================================================

-- Build hooks must be registered before vim.pack.add so they fire on install
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then return end
    local name = ev.data.spec.name
    -- Both nvim-treesitter and telescope-fzf-native require a `make` build step
    if name == "nvim-treesitter" or name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path })
    end
  end,
})

local plugins = {
  "https://github.com/Aejkatappaja/sora",
  "https://github.com/nvim-lua/plenary.nvim",                        -- required by telescope + neogit
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",     -- compiled fzf sorter for telescope
  "https://github.com/Saghen/blink.cmp",                             -- completion (fetches prebuilt Rust binary on first run)
  "https://github.com/stevearc/oil.nvim",                            -- edit filesystem as a buffer
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/lewis6991/gitsigns.nvim",                      -- gutter signs + hunk operations
  "https://github.com/echasnovski/mini.nvim",                        -- using mini.statusline only
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/windwp/nvim-ts-autotag",

}

-- vim.pack stores plugins in pack/core/opt/ — packadd each one so require() calls below work
vim.pack.add(plugins)
for _, url in ipairs(plugins) do
  vim.cmd("packadd " .. url:match("([^/]+)$"))
end

-- =============================================================================
-- LSP
-- =============================================================================

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.config("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs", "eslint.config.js", "eslint.config.mjs", "package.json", ".git" },
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
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" },
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
      runtime = { version = "LuaJIT" },   -- neovim uses LuaJIT
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),  -- index neovim runtime
      },
      diagnostics = { globals = { "vim" } },  -- suppress "undefined global vim" warnings
    },
  },
})

vim.lsp.enable({ "ts_ls", "eslint", "tailwindcss", "sqls", "nil_ls", "lua_ls" })

-- =============================================================================
-- Keymaps
-- =============================================================================
local map = vim.keymap.set
local tel = require("telescope.builtin")

-- Telescope
map("n", "<leader>ff", tel.find_files,              { desc = "Find files" })
map("n", "<leader>fg", tel.live_grep,               { desc = "Live grep" })
map("n", "<leader>fb", tel.buffers,                 { desc = "Buffers" })
map("n", "<leader>fs", tel.lsp_document_symbols,    { desc = "Document symbols" })
map("n", "<leader>fS", tel.lsp_workspace_symbols,   { desc = "Workspace symbols" })
map("n", "<leader>fd", tel.diagnostics,             { desc = "Diagnostics" })
map("n", "<leader>fk", tel.keymaps,                 { desc = "Keymaps" })
map("n", "<leader>fc", tel.commands,                { desc = "Commands" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>",    { desc = "Todo comments" })

-- Flash
map({ "n", "x", "o" }, "s", function() require("flash").jump() end,   { desc = "Flash jump" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash treesitter" })

-- Oil
map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Neogit
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit" })

-- Diagnostics
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,  { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                          { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",             { desc = "Buffer diagnostics (Trouble)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                  { desc = "Symbols (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",   { desc = "LSP definitions/refs (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                               { desc = "Quickfix list (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                              { desc = "Location list (Trouble)" })

-- LSP keymaps — only active when an LSP is attached to the buffer
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    map("n", "gd",         vim.lsp.buf.definition,   vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    map("n", "gD",         vim.lsp.buf.declaration,  vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    map("n", "gi",         vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    map("n", "gr",         tel.lsp_references,       vim.tbl_extend("force", opts, { desc = "References" }))
    map("n", "K",          vim.lsp.buf.hover,        vim.tbl_extend("force", opts, { desc = "Hover docs" }))
    map("n", "<leader>rn", vim.lsp.buf.rename,       vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    map("n", "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
  end,
})

-- =============================================================================
-- Plugin configuration
-- =============================================================================

-- Colorscheme
require("sora").setup()
vim.cmd("colorscheme sora")

-- Treesitter
-- nvim-treesitter v1.x removed the configs module; highlighting is via built-in vim.treesitter.
-- Install parsers once with :TSInstall typescript tsx javascript css html sql lua nix
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact", "css", "html", "sql", "lua", "nix", "markdown" },
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)   -- pcall: silently skip if parser not yet installed
  end,
})

-- blink.cmp — LSP, path, buffer sources only; snippets excluded
require("blink.cmp").setup({
  sources = {
    default = { "lsp", "path", "buffer" },
  },
  keymap = {
    preset = "default",
    ["<Up>"]   = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
  },
  fuzzy = { implementation = "lua" },  -- no prebuilt Rust binary needed; pure-Lua fallback
  completion = {
    menu = { border = "rounded" },
    documentation = { window = { border = "rounded" } },
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
require("oil").setup()

-- Gitsigns
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function bmap(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    bmap("n", "]h",         function() gs.nav_hunk("next") end, "Next hunk")
    bmap("n", "[h",         function() gs.nav_hunk("prev") end, "Prev hunk")
    bmap("n", "<leader>hs", gs.stage_hunk,                     "Stage hunk")
    bmap("n", "<leader>hp", gs.preview_hunk,                   "Preview hunk")
    bmap("n", "<leader>hb", gs.blame_line,                     "Blame line")
  end,
})

-- Neogit
require("neogit").setup({})

-- mini.icons — replaces nvim-web-devicons; mock call keeps plugins that require it working
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- mini.pairs — auto-close brackets, quotes, etc.
require("mini.pairs").setup()

-- mini.statusline
require("mini.statusline").setup()

-- which-key — shows popup of available keymaps after pressing a prefix
require("which-key").setup()

-- trouble.nvim — pretty list for diagnostics, references, quickfix, location list
require("trouble").setup()

-- nvim-lint — sqlfluff for SQL (all other filetypes are covered by LSPs)
local lint = require("lint")
lint.linters_by_ft = { sql = { "sqlfluff" } }
lint.linters.sqlfluff.args = { "lint", "--format", "json", "--dialect", "postgres" }
vim.api.nvim_create_autocmd("BufWritePost", { callback = function() lint.try_lint() end })
vim.api.nvim_create_autocmd("BufReadPost",  { callback = function() lint.try_lint() end })

-- conform.nvim — formatting with format-on-save
require("conform").setup({
  formatters_by_ft = {
    javascript      = { "prettier" },
    javascriptreact = { "prettier" },
    typescript      = { "prettier" },
    typescriptreact = { "prettier" },
    css             = { "prettier" },
    html            = { "prettier" },
    json            = { "prettier" },
    lua             = { "stylua" },
    nix             = { "nixfmt" },
    sql             = { "sqlfluff" },
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
require("nvim-ts-autotag").setup()

-- nvim-surround — ys/ds/cs to add, delete, change surroundings; defaults are fine
require("nvim-surround").setup()

-- flash.nvim — no setup needed beyond keymaps; defaults are fine
---@diagnostic disable-next-line: missing-fields
require("flash").setup({
  modes = {
    search = {
      enabled = true
    }
  }
})
