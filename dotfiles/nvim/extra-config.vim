" Comments must be on newlines, not as suffix to the command
" otherwise vim reads the whitespace up to the comment character
" and treats it as part of the command

let g:mapleader="\<SPACE>"

" Rehome some dirs
set backupdir=~/.nvim/backup
set directory=~/.nvim/swap
set undodir=~/.nvim/undo

" Allow copy/paste from anywhere
set clipboard=unnamedplus

" Highlight 100th column
set colorcolumn=100

" Insert mode completion
set completeopt=menu,menuone,noselect,noinsert

" Highlight current line
set cursorline

" Enable hidden buffers (navigate away from buffer with unsaved changes)
set hidden

" Enable the mouse in all modes
set mouse=a

" Disable current-mode message
set noshowmode

" Disable swap files for buffers
set noswapfile

" Disable line wrapping
set nowrap

" Don't use file backups
set nowritebackup

" Show line numbers
set number

" Number of lines to show around cursor
set scrolloff=30

" Disable shada
set shada=" "
set shadafile=NONE

" Number of spaces to use for each step of (auto)indent
set shiftwidth=2

" Don't show completion messages
set shortmess=c

" Always render a sign column
set signcolumn=yes

" Use smart autoindenting when starting a new line
set smartindent

" Open new splits below
set splitbelow

" Open new splits to the right
set splitright

" Number of spaces that a <Tab> in the file counts for
set tabstop=2

" Enable 24-bit colors in terminal vim
set termguicolors

" Time to wait for key combo
set timeoutlen=500

" Clear search results
nnoremap <ESC> :nohlsearch<CR>

" Move cursor between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Create windows
map <C-S-h> :topleft vnew<cr>
map <C-S-j> :botright new<cr>
map <C-S-k> :topleft new<cr>
map <C-S-l> :botright vnew<cr>

" remain in visual mode while indenting
vmap < <gv
vmap > >gv

" reload file on focus if it changed on disk
autocmd FocusGained * silent! checktime
