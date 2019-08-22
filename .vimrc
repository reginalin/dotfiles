" Author: Regina Lin
" 
" Installation:	
" 1. Using Neovim, soft-link this file to ~/.config/nvm/init.vim
" 2. Install Vim-Plug to manage plugins by running this command: 
" 	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Folding:
" zi: toggles everything ??? 
" za: toggles current selection
"
" General: Global config {{{
" SwapFiles: prevent their creation
set nobackup
set noswapfile

" Line Wrapping: do not wrap lines by default
set nowrap

set showtabline=2

set number

" Show line break bar
if exists('&colorcolumn')
	set colorcolumn=79
endif

" Folding
set foldmethod=marker

" }}}
" General: Vim-Plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'erichdongubler/vim-sublime-monokai'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim'
Plug 'pangloss/vim-javascript'

call plug#end()
" }}}
" Plugin Configurations {{{
" Sublime monokai
syntax on 
colorscheme sublimemonokai

" --------------------------------------------------------------------------------
" Nerdtree
" open on startup
" autocmd vimenter * NERDTree 

" open Nerdtree even if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open using Ctrl+n
map <C-n> :NERDTreeToggle<CR>  

" --------------------------------------------------------------------------------
" Deoplete autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" --------------------------------------------------------------------------------
"  Vim-Javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

"" Code folding for JS 
"augroup javascript_folding
"    au!
"    au FileType javascript setlocal foldmethod=syntax
"augroup END
" }}}
" Language specific {{{
" JavaScript (tab width 4 chr, wrap at 79th)
autocmd FileType javascript set sw=4
autocmd FileType javascript set ts=4
autocmd FileType javascript set sts=4

" }}}
