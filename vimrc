syntax on

set number relativenumber
set ignorecase

set encoding=utf-8

set fileencoding=utf8

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4

filetype plugin indent on

set backspace=indent,eol,start

"FILE SEARCH:
"------------
"allows FZF to open by pressing CTRL-F
map <C-p> :FZF<CR>
"allow FZF to search hidden 'dot' files
let $FZF_DEFAULT_COMMAND = "find -L"

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

au filetype go inoremap <buffer> . .<C-x><C-o>

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
map fgb :Gblame<CR>
map fgs :Gstatus<CR>
map fgl :Glog<CR>
map fgd :Gdiff<CR>

" Terraform configuration
let g:terraform_align=1
let g:terraform_fmt_on_save=1

