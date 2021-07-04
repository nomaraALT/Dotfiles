" Map leader to
let mapleader = " "
let maplocalleader = " "

set nocompatible
set updatetime=300
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
syntax on

" File format
filetype plugin indent on
set noswapfile
set nobackup
set nowritebackup
set fileformats=unix,dos

" Plugins
call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-commentary'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'mbbill/undotree'
  Plug 'will133/vim-dirdiff'
  Plug 'unblevable/quick-scope'
  Plug 'preservim/tagbar'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-surround'
  Plug 'jnurmine/Zenburn'
  Plug 'jiangmiao/auto-pairs'

call plug#end()

" Ctrl-P
set wildignorecase
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,*.exe,*.dll,*.png,*.jpg,*.so,*.lib,*.zip,*.gz,*.bmp,*.gif,*.jpeg,*.doc,*.pdf,*.xls,*.xlsx,*.docx,*.csproj,*.pdb,*.resx,*.sln,*.suo,*.out,*.idb

" Undotree
set undodir=~/.vim/undo-dir
set undofile
nnoremap <F5> :UndotreeToggle<CR>

" Tagbar
let g:tagbar_ctags_bin ='$HOME\vimfiles\ctags\ctags.exe'
let g:tagbar_position = 'leftabove'
let g:tagbar_height = 18
let g:tagbar_autofocus = 1
let g:tagbar_show_data_type = 1
let g:tagbar_show_tag_linenumbers = 2
nnoremap <leader>u :TagbarToggle<CR>

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

" Indent in visual mode
vnoremap < <gv
vnoremap > >gv

" Search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Coc
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nnoremap <F4> :CocDiagnostics<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

 " Abbreviations from https://vim-bootstrap.com/
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


if has("clipboard")
    if has("unnamedplus")
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif
else
    set clipboard=
endif

" Statusline
set modeline
set modelines=10
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"Colorscheme
if has("gui_running")
  set guioptions=egc " Remove menu bar , tool bar scrollbar etc
  set columns=180 lines=60 " Gui size

  if has("win32") || has("win64")
    set gfn=Iosevka_Fixed_Extended:h10:cANSI:qDRAFT " Gui font
    set renderoptions=type:directx
  elseif has("unix")
    set gfn=Monospace\ 10
  endif

else
  set t_Co=256

  if &term == "screen-256color"
    set term=xterm-256color
  endif
  if has("termguicolors") && $COLORTERM ==? "truecolor"
    set termguicolors
  endif

endif

let g:zenburn_disable_Label_underline = 1
colorscheme Zenburn

" Some AutoCmd rules and functions from https://vim-bootstrap.com/
command! FixWhitespace :%s/\s\+$//e
autocmd BufWritePost * :FixWhitespace

augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread
