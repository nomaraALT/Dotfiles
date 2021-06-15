"==============================================
"=================== Basic=====================
"==============================================

" Map leader to
let mapleader = " "

set nocompatible
set updatetime=750
set shortmess+=c

" hidden buffers
set hidden

" Backspace indent
set backspace=indent,eol,start

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Search
set hlsearch
set incsearch
set nohlsearch
set ignorecase
set smartcase

" Visuals
set number relativenumber
set cmdheight=1
set cursorline
set cursorcolumn
set ruler
set nowrap
syntax on

" File format
filetype plugin indent on
set noswapfile
set nobackup
set nowritebackup
set fileformats=unix,dos
set autoread

" Statusline
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"==============================================
"================= Plugins ====================
"==============================================

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mbbill/undotree'
Plug 'SirVer/ultisnips'
Plug 'ycm-core/YouCompleteMe'
Plug 'honza/vim-snippets'
Plug 'jonathanfilip/vim-lucius'

call plug#end()

" Ultisnips
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
" let g:UltiSnipsEditSplit="vertical"

set wildignorecase
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.exe,*.dll,*.png,*.jpg,*.so,*.lib,*.zip,*.gz,*.bmp,*.gif,*.jpeg,*.doc,*.pdf,*.xls,*.xlsx,*.docx,*.csproj,*.pdb,*.resx,*.sln,*.suo,*.out,*.idb

" Undotree 
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

"==============================================
"=============== Colorscheme ==================
"==============================================

if has("gui_running")
    " Remove menu bar , tool bar scrollbar etc 
    set guioptions-=m  
    set guioptions-=T  
    set guioptions-=r  
    set guioptions-=L
    " Gui size
    set columns=180 lines=60
    " Gui font
    if has("win32") || has("win64")
        set guifont=Consolas:h11:cANSI
    elseif has("unix")
        set guifont=Inconsolata\ 11
    endif
else
    if &term == "screen-256color"
        set term=xterm-256color
    endif
    if has("termguicolors") && $COLORTERM ==? "truecolor"
        set termguicolors
    endif
endif

colorscheme lucius

"==============================================
"================= Mapping ====================
"==============================================

" Switching windows 
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Resize windows
nnoremap <Up> 10<C-W>+
nnoremap <Down> 10<C-W>-
nnoremap <Left> 10<C-W><
nnoremap <Right> 10<C-W>>

" Youcompleteme
nmap <leader>gp :YcmCompleter GoToDefinition<CR>
nmap <leader>gpp :YcmCompleter GoToDeclaration<CR>
nmap <leader>gr :YcmCompleter GoToReferences<CR>
nmap <leader>gt :YcmCompleter GoToInclude<CR>
nmap <leader>grr :YcmCompleter RefactorRename<CR>

" Undotree
nnoremap <silent> <leader>u :UndotreeShow<CR>

if has("clipboard")
    if has("unnamedplus")
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif
else
    set clipboard=
endif

"==============================================
"============== Abbreviations =================
"==============================================

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
