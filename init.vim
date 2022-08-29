syntax enable
filetype plugin indent on
set guicursor=i:block
set backspace=indent,eol,start
set ls=2
let &t_SI.="\e[5 q" "SI = INSERT mode
set number 
set relativenumber
set nu
" set cursorline
" set cursorcolumn
set smartcase
set ignorecase
set incsearch
set autoindent
set shiftwidth=2
set tabstop=2
set expandtab
set sw=2
set exrc
set nohlsearch
set hidden
set noerrorbells
set nowrap
set nobackup
set noswapfile
set undofile
set scrolloff=8
set bs=2
set mouse=a
set wildmode=full
set encoding=UTF-8
set lazyredraw

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-r>=icr#ICR()\<CR>"


autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber 

" Autoclose { and [
:imap { {}<left>
:imap [ []<left>


let mapleader = " " " Map leader

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
noremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>t :below terminal<CR>

call plug#begin()

" Customization
" Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/preservim/nerdtree'
Plug 'majutsushi/tagbar'


Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'https://github.com/bluz71/vim-nightfly-guicolors.git'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'tomasiser/vim-code-dark'
Plug 'https://github.com/sainnhe/everforest.git'
Plug 'mhartington/oceanic-next' 
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'https://github.com/AlessandroYorba/Alduin.git'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }

Plug 'tribela/vim-transparent' " Transparent bg

" Uitility
Plug 'https://github.com/tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'othree/html5.vim'
Plug 'ryanoasis/vim-devicons' " Dev Icons
Plug 'kqito/vim-easy-replace' " Easy Replace 

" AutoCompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

call plug#end()

" Colorscdark
set background=dark
set termguicolors
colorscheme tokyonight
let g:tokyonight_italic_keywords = 0
" colorscheme deep-space
" colorscheme gruvbox

" set statusline=%f[%m](%l,%v)
set statusline=[%n]\ %<%F\ \ \ [%M%R%H%W%Y]\ \ %=\ %l/%L\ \ \ \ %p%%\ \ \ 

:map <F1> :NERDTree<Return>
:map <F2> :NERDTreeClose <Return>
:map <C-z> :vertical resize -2<Return>
:map <C-x> :vertical resize +2<Return>
:map <F3> :TagbarToggle<CR>
:nmap <C-\> :ToggleTerm direction=float<CR>

:map <leader>r :EasyReplaceWord <Cr>

:map <leader>f :FZF<CR>

" Airline Config
:map <leader>n :bn <CR>
:map <leader>m :bp <CR>

let g:netrm_browse_split = 2
let g:netrm_banner = 0
" set showtabline=2
" set noshowmode

" let g:airline#extensions#tabline#enabled = 1

" Autosave
autocmd TextChanged,TextChangedI <buffer> silent write

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
source $HOME/.config/nvim/plug-config/coc.vim

" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
EOF

lua << EOF
local lsp_installer = require "nvim-lsp-installer"

-- Include the servers you want to have installed by default below
local servers = {
  "bashls",
  "pyright",
  "clangd",
  "tsserver",
  "vimls",
  "rust-analyzer",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

local enhance_server_opts = {
  -- Provide settings that should only apply to the "eslintls" server
  ["eslintls"] = function(opts)
    opts.settings = {
      format = {
        enable = true,
      },
    }
  end,
}

lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local opts = {
    on_attach = on_attach,
  }

  if enhance_server_opts[server.name] then
    -- Enhance the default opts with the server-specific ones
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
  end)

EOF
