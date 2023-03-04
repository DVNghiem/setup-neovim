
let mapleader = "\<Space>"

nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <leader>fr :RustFmt<CR>

nnoremap <leader>q :bp<cr>:bd #<cr>
nnoremap <C-Left> :bp<CR>
nnoremap <C-Right> :bn<CR>

inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>

nnoremap <c-z> <nop>
snoremap <c-z> <nop>

noremap <silent> <c-k> :wincmd k<CR>
noremap <silent> <c-j> :wincmd j<CR>
noremap <silent> <c-h> :wincmd h<CR>
noremap <silent> <c-l> :wincmd l<CR>
nnoremap <C-a> ggVG
noremap <F12> <c-]><CR>


inoremap jk <ESC>
nnoremap ; :
nnoremap <C-s> :w<CR>
nnoremap <C-w> :q<CR>

set noswapfile
set scroll=5
set tabstop=4
set softtabstop=0
set shiftwidth=4
set encoding=UTF-8
set mouse=a
set number
set relativenumber

noremap <Up> 5k
noremap <Down> 5j



set tabstop=4
set smarttab
set softtabstop=4



syntax enable
filetype plugin indent on


set t_Co=256
set background=dark
colorscheme dracula
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

nnoremap <leader>ff <cmd>Telescope find_files<cr>


"fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:fzf_layout = { 'window': { 'width': 1, 'height': 1 } }



let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.hbs'


"airline {{
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 0
"}}


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:deoplete#enable_at_startup = 1

highlight! link NERDTreeFlags NERDTreeDir
