" Basics
let mapleader = " "
set nocompatible
set hidden
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set clipboard=unnamed
set backspace=2
set noswapfile
set nowrap
set nobackup
set nowritebackup
set incsearch
set nohlsearch
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set autoindent
set cindent
set cmdheight=2
set updatetime=100
set shortmess+=c
set cursorline
set cursorcolumn
set guifont=Consolas:h13:cANSI

command! Wq wq
command! W w
command! Q q

" Remove menu bar , tool bar scrollbar etc from the GUI
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
set guioptions-=L

" Gui size
set columns=80 lines=90

" Statusline
set noshowmode
set laststatus=2

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set statusline=
set statusline+=%0*\ %n\                     
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%1*\ %<%F%m%r%h%w\          
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %2p%%
set statusline+=\ %l:%c
set statusline+=\ 


" Plugins 
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'mbbill/undotree'
Plug 'SirVer/ultisnips'
Plug 'ycm-core/YouCompleteMe'
Plug 'jonathanfilip/vim-lucius'

call plug#end()


" Colorscheme 
if (has("termguicolors"))
 set termguicolors
endif
colorscheme lucius
set background=dark
set t_Co=256
set nu

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <leader>p :Buffers<CR>

" Undotree 
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
nnoremap <leader>u :UndotreeShow<CR>

" Move around windows 
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

