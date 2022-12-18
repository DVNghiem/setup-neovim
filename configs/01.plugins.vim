
set nocompatible
set encoding=utf8

call plug#begin('~/.config/nvim/bundle')

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'preservim/nerdtree'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

Plug 'dense-analysis/ale'

Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

"Plug 'Shougo/deoplete.nvim'

"fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'

"snippets
"Plug 'honza/vim-snippets'
"Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive' "git
Plug 'majutsushi/tagbar'

Plug 'ekalinin/dockerfile.vim'

call plug#end()

:luafile ~/.config/nvim/configs/tree-sitter.lua
