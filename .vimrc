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

 

" General: Global config {{{
" Enable hidden buffers "
set hidden 

" SwapFiles: prevent their creation
set nobackup
set noswapfile

" Enable filetype detection, plugins, and indentation "
filetype plugin indent on

" Line Wrapping: do not wrap lines by default
set nowrap

set showtabline=2

" Line number 
set relativenumber 
set number

" Show line break bar
if exists('&colorcolumn')
	set colorcolumn=79
endif

" Folding
set foldmethod=marker

" Line highlights 
set cursorline

" press space to disable highlights after search 
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" don't timeout on mappings
set notimeout

" do timeout on terminal key codes
set ttimeout

" Filetype recognition "
augroup filetype_recognition
  autocmd!
  autocmd BufNewFile,BufRead,BufEnter *.hql,*.q set filetype=hive
  autocmd BufNewFile,BufRead,BufEnter *.config,.cookiecutterrc set filetype=yaml
  autocmd BufNewFile,BufRead,BufEnter .jrnl_config,*.bowerrc,*.babelrc,*.eslintrc,*.slack-term
        \ set filetype=json
  autocmd BufNewFile,BufRead,BufEnter *.asm set filetype=nasm
  autocmd BufNewFile,BufRead,BufEnter *.handlebars set filetype=html
  autocmd BufNewFile,BufRead,BufEnter *.m,*.oct set filetype=octave
  autocmd BufNewFile,BufRead,BufEnter *.jsx set filetype=javascript
  autocmd BufNewFile,BufRead,BufEnter *.gs set filetype=javascript
  autocmd BufNewFile,BufRead,BufEnter *.cfg,*.ini,.coveragerc,*pylintrc
        \ set filetype=dosini
  autocmd BufNewFile,BufRead,BufEnter *.tsv set filetype=tsv
  autocmd BufNewFile,BufRead,BufEnter *.toml set filetype=toml
  autocmd BufNewFile,BufRead,BufEnter Dockerfile.* set filetype=Dockerfile
  autocmd BufNewFile,BufRead,BufEnter Makefile.* set filetype=make
  autocmd BufNewFile,BufRead,BufEnter poetry.lock set filetype=toml
  autocmd BufNewFile,BufRead,BufEnter .gitignore,.dockerignore
        \ set filetype=conf
augroup END

" }}}
" General: Remapping {{{
" vim split navigation
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <C-O> <C-W>w

" }}}
" General: Vim-Plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'erichdongubler/vim-sublime-monokai' " color scheme
Plug 'scrooloose/nerdtree' " file explorer
Plug 'Shougo/deoplete.nvim' " autocomplete
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-ragtag' " tag closings
Plug 'scrooloose/nerdcommenter' " commenting support
Plug 'yggdroot/indentline'
Plug 'pappasam/vim-filetype-formatter'
Plug 'davidhalter/jedi-vim' "jump to definition
Plug 'tpope/vim-surround' "add brackets around things ysiw* yss*
Plug 'chiel92/vim-autoformat'

" Javascript
Plug 'pangloss/vim-javascript' 
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Valloric/MatchTagAlways'
Plug 'beautify-web/js-beautify' "formatter for js

" Language specific highlighting
Plug 'evanleck/vim-svelte' "svelte highlights
Plug 'mxw/vim-jsx'
Plug 'rust-lang/rust.vim' " Rust highlights

call plug#end()
" }}}
" Plugin Configurations {{{
" color scheme {{{
syntax on 
colorscheme sublimemonokai
" }}}
" nerdtree {{{
" open on startup
" autocmd vimenter * NERDTree 

" open Nerdtree even if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open using Ctrl+n
map <C-n> :NERDTreeToggle<CR>  
" }}} 
" autocomplete {{{
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

let g:neosnippet#enable_completed_snippet = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" }}}
" tag closings {{{
let g:ragtag_global_maps = 1

augroup ragtag_config
  autocmd!
  autocmd FileType javascript call RagtagInit()
  autocmd FileType svelte call RagtagInit()
augroup end

" }}}
" MatchTag {{{
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \'javascript': 1,
    \}
" }}}
" indent guides {{{
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"hi IndentGuidesOdd  guibg=white ctermbg=3
"hi IndentGuidesEven guibg=white ctermbg=4
"let g:indent_guides_guide_size = 1 " set skinny line guides 
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
"let g:indentLine_char = '|'
" }}}
" }}}
" Language specific {{{
set expandtab shiftwidth=2 softtabstop=2 tabstop=8
augroup indentation_sr
  autocmd!
  autocmd Filetype python,c,haskell,markdown,rust,rst,kv,nginx,asm,nasm,gdscript3
        \ setlocal shiftwidth=4 softtabstop=4 tabstop=8
  autocmd Filetype dot setlocal autoindent cindent
  autocmd Filetype make,tsv,votl,go
        \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  " Prevent auto-indenting from occuring
  autocmd Filetype yaml setlocal indentkeys-=<:>

  autocmd Filetype ron setlocal cindent
        \ cinkeys=0{,0},0(,0),0[,0],:,0#,!^F,o,O,e
        \ cinoptions+='(s,m2'
        \ cinoptions+='(s,U1'
        \ cinoptions+='j1'
        \ cinoptions+='J1'
augroup END

" JavaScript (tab width 2 chr, wrap at 79th)
"autocmd FileType javascript set sw=2
"autocmd FileType javascript set ts=2
"autocmd FileType javascript set sts=2

"autocmd FileType json set sw=2
"autocmd FileType json set ts=2
"autocmd FileType json set sts=2

"autocmd FileType html set sw=2
"autocmd FileType html set ts=2
"autocmd FileType html set sts=2

"autocmd FileType css set sw=2
"autocmd FileType css set ts=2
"autocmd FileType css set sts=2

"autocmd FileType yaml set sw=2
"autocmd FileType yaml set ts=2
"autocmd FileType yaml set sts=2

"autocmd FileType md set sw=2
"autocmd FileType md set ts=2
"autocmd FileType md set sts=2
" }}}
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure
