" General config

syntax on
let mapleader = ";"

set number relativenumber
set ignorecase
set autoread
"set cursorline

"use y and p with the system clipboard
set clipboard=unnamedplus

set encoding=utf-8
set fileencoding=utf-8
set updatetime=100

set bg=dark

" Remapping

"Navigate buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>

" FILE SEARCH:
" ------------
"allows FZF to open by pressing CTRL-F
"map <C-p> :FZF<CR>
"allow FZF to search hidden 'dot' files
"let $FZF_DEFAULT_COMMAND = "find -L"

" Find files using Telescope command-line sugar.
nnoremap <leader>fb :Telescope file_browser<CR>
nnoremap <silent>ff <cmd>Telescope find_files<cr>
nnoremap <silent>fg <cmd>Telescope live_grep<cr>
nnoremap <silent>fb <cmd>Telescope buffers<cr>
nnoremap <silent>fh <cmd>Telescope help_tags<cr>

"****************************************************
"Markdown Preview Recommended Settings
"****************************************************
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1 

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 1 

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''
" Markdown Preview
map <C-p> :MarkdownPreview<CR>


" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" NERDTree plugin specific commands
map nt :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=2
" Add a close button in the upper right for tabs
let g:tablineclosebutton=1
" Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1
" Add folder icon to directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
" Add a close button in the upper right for tabs
let g:tablineclosebutton=1
" Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1
" Add folder icon to directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" air-line plugin specific commands
let g:airline_powerline_fonts = 1

" GIT (FUGITIVE):
map fgb :Git blame<CR>
map fgs :Git<CR>
map fgl :Gclog<CR>
map fgd :Gdiff<CR>

"==================================================================================
"plugins
"==================================================================================

call plug#begin('~/.config/nvim/autoload/')

Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'EdenEast/nightfox.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'preservim/nerdcommenter'
Plug 'folke/todo-comments.nvim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

"Language packs
Plug 'sheerun/vim-polyglot'
"Grammar checking
Plug 'rhysd/vim-grammarous'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"LSP autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

"File browsing
Plug 'nvim-telescope/telescope-file-browser.nvim'

"Native LSP
Plug 'neovim/nvim-lspconfig'

"Buffer navigation
Plug 'vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim'


"Telescope Requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

call plug#end()

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua require("linuxin8789_cfg")

"colorscheme gruvbox
