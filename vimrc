" Custom settings for vim

" Formatting
set tabstop=2
set sw=2
set autoindent
syntax on
set rtp+=~/.vim/colors/
au VimResized * exe 
colorscheme ron
set number relativenumber 
set splitbelow splitright
set scrolloff=15
set backspace=indent,eol,start

set mouse=nicr

" Key remaps
let mapleader=" "
inoremap lj <Esc>
vnoremap lj <Esc> 
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <C-Right> <C-w>> 
nnoremap <C-Left> <C-w><
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-

" Leader remaps
nnoremap <leader>vs :vs<CR>
nnoremap <leader>sp :sp<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>f :set filetype=
nnoremap <leader>j :w<CR>:!clear; python3 %:p<CR>

" Statusline
set laststatus=2
set statusline=%F
set statusline+=\  
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%=      "left/right separator
set statusline+=%y      "filetype
set statusline+=\  
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" Return to previous cursor position
augroup line_return
au!
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\     execute 'normal! g`"zvzz' |
\ endif
augroup END