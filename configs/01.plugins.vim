
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
Plug 'gko/vim-coloresque'
Plug 'terryma/vim-multiple-cursors'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

"snippets
Plug 'majutsushi/tagbar'

Plug 'docker/docker'

call plug#end()

:luafile ~/.config/nvim/configs/tree-sitter.lua
:luafile ~/.config/nvim/configs/nvim-tree.lua
:luafile ~/.config/nvim/configs/devicon.lua
