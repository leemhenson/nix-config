local api = vim.api                     -- Access the Neovim API
local cmd = vim.cmd                     -- Execute Vim commands
local exec = api.nvim_exec          -- Execute Vimscript
local fn = vim.fn                       -- Call Vim functions
local g = vim.g                         -- Global variables
local opt = vim.opt                     -- Global/buffer/windows-scoped options
local map = vim.api.nvim_set_keymap     -- Keymapping

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = ' '
g.maplocalleader = ' '

opt.backup = false                      -- Disable overwrite-backup files
opt.clipboard = 'unnamedplus'           -- Allow copy/paste from anywhere
opt.colorcolumn = '100'                 -- Highlight 100th column
opt.completeopt = 'menuone,noselect,noinsert' -- Completion options
opt.cursorline = true                   -- Highlight current line
opt.errorbells = false                  -- Don't beep on errors
opt.expandtab = false                   -- Don't use spaces instead of tabs
opt.hidden = true                       -- Enable hidden buffers (navigate away from buffer with unsaved changes)
opt.hlsearch = false                    -- Don't highlight all search matches
opt.incsearch = true                    -- Makes search act like search in modern browsers
opt.mouse = 'a'                         -- Enable mouse in all modes
opt.number = true                       -- Show line numbers
opt.scrolloff = 15                      -- Number of lines to show around cursor
opt.shada = ''                          -- Disable shada
opt.shadafile = 'NONE'                   -- Disable shada
opt.shell = '/etc/profiles/per-user/leemhenson/bin/zsh'    -- Use my zsh as default in terminal
opt.shiftwidth = 2                      -- Number of spaces to use for each step of (auto)indent
opt.shortmess = 'c'                     -- Don't show completion messages
opt.showmode = false                    -- Diasble current-mode message
opt.signcolumn = 'yes'                  -- Always render a sign column
opt.smartindent = true                  -- Smart autoindenting when starting a new line
opt.splitbelow = true                   -- Open new splits below
opt.splitright = true                   -- Open new splits to the right
opt.swapfile = false                     -- Disable swapfile for buffers
opt.syntax = 'on'                       -- Enable syntax highlighting
opt.tabstop = 2                         -- Number of spaces that a <Tab> in the file counts for
opt.termguicolors = true                -- Enable 24-bit colors in terminal vim
opt.timeout = true                      -- Wait for mapped sequence to complete
opt.timeoutlen = 300                    -- Time in milliseconds to wait for a mapped sequence to complete.
opt.wrap = false                        -- Don't wrap lines
opt.writebackup = false                 -- Disable overwrite-backup files

-- Reload file when focusing, if it has changed on disk
cmd[[autocmd FocusGained * silent! checktime]]

-- Default keymapping options
local map_opts = {noremap = true, silent = true}

-- Clear search highlights
map('n', '<C-/>', ':nohl<CR>', map_opts)

-- Nvim-tree
map('n', '<M-b>', ':NvimTreeToggle<CR>', map_opts)

-- Telescope
map('n', '<M-F>', ':Telescope live_grep<CR>', map_opts)
map('n', '<M-p>', ':Telescope buffers<CR>', map_opts)
map('n', '<M-P>', ':Telescope commands<CR>', map_opts)
map('n', '<leader>ff', ':Telescope find_files<CR>', map_opts)
map('n', '<leader>fk', ':Telescope keymaps<CR>', map_opts)
map('n', '<leader>ft', ':Telescope file_browser<CR>', map_opts)

-- Windows
map('n', '<C-h>', '<C-w>h', map_opts)
map('n', '<C-j>', '<C-w>j', map_opts)
map('n', '<C-k>', '<C-w>k', map_opts)
map('n', '<C-l>', '<C-w>l', map_opts)

function move_buffer_to_split(direction)
  local current_window = vim.api.nvim_call_function('winnr', {})
  local adjacent_window = vim.api.nvim_call_function('winnr', {direction})

  local message_type = "WarningMsg"  -- Use "Msg", "WarningMsg", "ErrorMsg", or "MoreMsg" for different message types

  local current_buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(current_buf)

  local message = "Current window: " .. (current_window or "") .. "\nAdjacent window: " .. (adjacent_window or "") .. "\nBuffer: " .. (current_buf or "") .. "\nBuffer name: " .. (buf_name or "")

  vim.api.nvim_echo({{ message, message_type }}, true, {}) -- line 85
end

map('n', '<C-D-Left>',  ':lua move_buffer_to_split(\'h\')<CR>', map_opts)
map('n', '<C-D-Right>', ':lua move_buffer_to_split(\'l\')<CR>', map_opts)
map('n', '<C-D-Up>',    ':lua move_buffer_to_split(\'k\')<CR>', map_opts)
map('n', '<C-D-Down>',  ':lua move_buffer_to_split(\'j\')<CR>', map_opts)

require('nightfox').setup()
vim.cmd [[colorscheme nordfox]]

require('lualine').setup()
require('neogit').setup()
require("nvim-tree").setup()
require('telescope').setup({
  defaults = require("telescope.themes").get_ivy({
    layout_config = {
      height = 0.6
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      }
    }
  })
})
require('telescope').load_extension('fzf')
require("which-key").setup()
