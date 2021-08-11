"==================
"===Editor Setup===
"==
"== System
"==

let &t_ut=''
set autochdir
set clipboard+=unnamedplus


syntax on
set number 
set relativenumber
set cursorline "显示一条线
set wrap 
set showcmd "显示command
set wildmenu

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5  "保持下方有5行

set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set laststatus=2
"光标自动定位到上一次操作的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif



let mapleader=" "

noremap j h
noremap l l
noremap i k
noremap k j

noremap h i
noremap H I

noremap J 7h
noremap L 7l
noremap I 5k
noremap K 5j

"返回的返回
noremap <C-p> <C-i>

"copy to system clipbordplus
"set clipboard=unnamedplus
vnoremap Y "+y

noremap = nzz
noremap - Nzz
noremap <LEADER><CR> :nohlsearch<CR>

map R :source $MYVIMRC<CR>

"
" system
"
"Check the spell

noremap <C-x> ea<C-x>s
inoremap <C-x> <Esc>ea<C-x>s

map <LEADER>sc :set spell!<CR>
"split

map sj :set nosplitright<CR>:vsplit<CR>
map sl :set splitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>

"分屏移动

map <LEADER>j <C-w>h
map <LEADER>l <C-w>l
map <LEADER>i <C-w>k
map <LEADER>k <C-w>j

"map <up> k
"map <down> j
"map <left> h
"map <right> l
"分屏大小调整
map <C-k> :res -5<CR>
map <C-i> :res +5<CR>
map <C-j> :vertical resize-5<CR>
map <C-l> :vertical resize+5<CR>
"标签页移动
noremap tu :tabnew<CR>
map tj :tabn<CR>
map tl :tabp<CR>
"swich vertical-horizontal
map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K

map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l
map tx :r !figlet 

call plug#begin('~/.config/nvim/plugged') 

Plug 'vim-airline/vim-airline'
"Theme
"Plug 'connorholyday/vim-snazzy'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
"
Plug 'vim-airline/vim-airline-themes'

"nerdtree
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'  "show icons in nerdtree

" File navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Plug 'junegunn/vim-peekaboo'

"Editor Enhancement
Plug 'preservim/nerdcommenter'

"debuger
Plug 'puremourning/vimspector',{'do': './install_gadget.py --enable-python --enable-c --force-enable-java'}

"Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}


call plug#end()

"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48:2;%lu;%lu;%lum"


"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_section_y = ''

"let g:SnazzyTransparent = 1
"colorscheme snazzy
""""""""""""""""""""""""""""""""""""""""""""""
""""
""""airline
""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='dark'

"colorscheme default
"""
"""
"""
let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
"default, palenight, ocean, lighter, and darker.
colorscheme material

" ===
" === NERDTree
" ===
map tt :NERDTreeToggle<CR>

" ==
" == NERDTree-git
" ==
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" ===
" === nerdcommenter
" ===
" Create default mappings

let g:NERDCreateDefaultMappings = 1


" ===
" === vimspector
" ===

let g:vimspector_enable_mappings = 'HUMAN'

function! s:read_template_into_buffer(template)
    " has to be a function to avoid the extra space fzf#run insers otherwise
    execute '0r ~/.config/nvim/vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
            \   'source': 'ls -1 ~/.config/nvim/vimspector_json',
            \   'down': 20,
            \   'sink': function('<sid>read_template_into_buffer')
            \ })

noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=🛑 texthl=Normal
sign define vimspectorBPDisabled text=🚫 texthl=Normal
sign define vimspectorPC text=👉 texthl=SpellBad
" ===
" === coc.nvim
" ===

"
" == coc.plug
"
let g:coc_global_extensions = [
      \'coc-explorer',
      \'coc-snippets',
      \'coc-vimlsp',
      \'coc-snippets',
      \'coc-json',
      \'coc-tsserver',
      \ 'coc-python',
      \'coc-pyright',
      \ 'coc-flutter-tools']
"
" == coc.settings
"

"# Set internal encoding of vim, not needed on neovim, since coc.nvim using some
"# unicode characters in the file autoload/float.vim

set encoding=utf-8

"# Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"# delays and poor user experience.
"# 让vim的响应更快一点

set updatetime=100

"# Don't pass messages to |ins-completion-menu|.
"# 补全的时候信息栏少输出一些没用的东西

set shortmess+=c

"# Use tab for trigger completion with characters ahead and navigate.
"# NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"# other plugin before putting this into your config.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

"# Make <CR> auto-select the first completion item and notify coc.nvim to
"# format on enter, <cr> could be remapped by other vim plugin

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"# Use `[g` and `]g` to navigate diagnostics
"# Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"# 在报错的位置进行跳转
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"# GoTo code navigation.

" 跳转到函数定义的位置
nmap <silent> gd <Plug>(coc-definition)  
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <LEADER>\ to show documentation in preview window.
nnoremap <silent> <LEADER>\ :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"# Symbol renaming.
"# 当前变量重命名
nmap <leader>rn <Plug>(coc-rename)

"# Remap for do codeAction of selected region

"function! s:cocActionsOpenFromSelected(type) abort
  "execute 'CocCommand actions.open ' . a:type
"endfunction
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>aw  <Plug>(coc-codeaction-selected)w

