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
let mapleader = ','
let maplocalleader = '\\'

" Enable filetype detection, plugins, and indentation "
filetype plugin indent on 

function! SetGlobalConfig()
  set hidden " Enable hidden buffers "
  set modifiable " Enable modifying of buffers (ex. Nerdtree refresh) "
  set nobackup  " SwapFiles: prevent their creation
  set nowritebackup
  set noswapfile
  set nowrap " Line Wrapping: do not wrap lines by default
  set showtabline=2
  set relativenumber 
  set number
  set foldmethod=marker " Folding
  set cursorline " Line highlights 
  set notimeout " don't timeout on mappings
  " do timeout on terminal key codes
  "set ttimeout
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab " tabs are spaces

  " for coc
  set cmdheight=2
  set updatetime=300
  set shortmess+=c 
  set signcolumn=yes

  set encoding=UTF-8
endfunction
call SetGlobalConfig()

" Show line break bar
if exists('&colorcolumn')
	set colorcolumn=80
endif

" Enable true color "
if $COLORTERM ==# 'truecolor'
  set termguicolors
else
  set guicursor=
endif

" }}}
" General: Filetype recognition{{{
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
"nnoremap <C-O> <C-W>w

" ~/.vimrc
" Remap formatting 
nnoremap <leader>f :FiletypeFormat<cr>
vnoremap <leader>f :FiletypeFormat<cr>

" Remap system copy "
vnoremap <Leader>Y "+y
vnoremap <Leader>P "+p

" press space to disable highlights after search 
noremap <silent> <Space> :silent noh<Bar>echo<CR>

inoremap jk <esc>

" }}}
" General: Vim-Plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'erichdongubler/vim-sublime-monokai' " color scheme
Plug 'nlknguyen/papercolor-theme' " color scheme
Plug 'itchyny/lightline.vim' " Airline/Powerline replacement
Plug 'scrooloose/nerdtree' " file explorer
"Plug 'ryanoasis/vim-devicons' " icons for Nerdtree
Plug 'townk/vim-autoclose'
Plug 'scrooloose/nerdcommenter' " commenting support
Plug 'yggdroot/indentline'
Plug 'pappasam/vim-filetype-formatter'
Plug 'tpope/vim-surround' "add brackets around things ysiw* yss*
Plug 'chiel92/vim-autoformat'
Plug 'pappasam/nvim-repl' " repls
Plug 'tpope/vim-repeat'

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Javascript / Typescript
Plug 'pangloss/vim-javascript' 
Plug 'peitalin/vim-jsx-typescript'
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'beautify-web/js-beautify' "formatter for js
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-ragtag' " tag closings
Plug 'alvan/vim-closetag'

" Language specific highlighting
Plug 'khalliday7/Jenkinsfile-vim-syntax'
Plug 'evanleck/vim-svelte' "svelte highlights
Plug 'mxw/vim-jsx'
Plug 'rust-lang/rust.vim' " Rust highlights
Plug 'cespare/vim-toml'
Plug 'posva/vim-vue' " vue
Plug 'maxmellon/vim-jsx-pretty' " jsx highlights
Plug 'leafgarland/typescript-vim' " ts syntax
Plug 'chr4/nginx.vim'
Plug 'vim-python/python-syntax'
Plug 'hashivim/vim-terraform'
"'martinda/Jenkinsfile-vim-syntax'
Plug 'vim-scripts/groovyindent-unix'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

Plug 'junegunn/limelight.vim' " spotlight content in vim
Plug 'junegunn/goyo.vim'

" Autocompletion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile && yarn build'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
for coc_plugin in [
      \ 'fannheyward/coc-markdownlint',
      \ 'fannheyward/coc-texlab',
      \ 'neoclide/coc-html',
      \ 'neoclide/coc-css',
      \ 'neoclide/coc-json',
      \ 'neoclide/coc-rls',
      \ 'neoclide/coc-yaml',
      \ 'coc-extensions/coc-svelte',
      \ 'pappasam/coc-jedi',
      \ 'neoclide/coc-tsserver',
      \ 'davidroeca/coc-svelte-language-tools'
      \ ]
  Plug coc_plugin, { 'do': 'yarn install --frozen-lockfile && yarn build' }
endfor

Plug 'wincent/ferret' " Search across files

" Markdown 
Plug 'dkarter/bullets.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

call plug#end()
" }}}
" Plugin Configurations: Vim-Plug {{{
" color scheme {{{
"syntax on 
"colorscheme sublimemonokai
"
set t_Co=256   " This is may or may not needed.
set background=dark
colorscheme PaperColor
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
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
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
    \'typescript': 1,
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
" filetype recognition{{{
augroup js_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.gs set filetype=javascript
  autocmd BufNewFile,BufFilePre,BufRead *.js.flow set filetype=javascript
augroup END
augroup jsx_recognition
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.jsx set filetype=javascript.jsx
augroup END
augroup tsx_recognition
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END
" }}}
" Vim Python {{{
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1
" }}}
" ale {{{
"let g:ale_sign_error = '✖'
"let g:ale_sign_warning = '⚠'
"let g:ale_sign_info = 'ℹ'
"let g:ale_enabled = 0
"augroup mapping_ale_fix
  "autocmd FileType python,javascript,javascript.jsx,typescript,
        "\ nnoremap  <space>ap :ALEPreviousWrap<cr> |
        "\ nnoremap  <space>an :ALENextWrap<cr> |
        "\ nnoremap  <space>at :ALEToggle<cr>
"augroup END
" }}}
" echodoc {{{
let g:echodoc#enable_at_startup = v:true
let g:echodoc#type = 'floating'
let g:echodoc#highlight_identifier = 'Identifier'
let g:echodoc#highlight_arguments = 'QuickScopePrimary'
let g:echodoc#highlight_trailing = 'Type'
" }}}
" Terraform {{{
let g:terraform_align = 1

let g:terraform_fold_sections = 0

let g:terraform_fmt_on_save = 1

let g:terraform_remap_spacebar = 1
" }}}
" Filetype formatter {{{
"let g:vim_filetype_formatter_commands = {
      "\ 'text': 'poetry run textformat',
      "\ 'javascript.jsx': g:filetype_formatter#ft#formatters['javascript']['prettier'],
      "\ 'typescript': g:filetype_formatter#ft#formatters['javascript']['prettier'],
      "\ 'typescript.tsx': g:filetype_formatter#ft#formatters['javascript']['prettier'],
      "\ 'vue': g:filetype_formatter#ft#formatters['javascript']['prettier'],
      "\ }
" }}}
" Language specific {{{
set expandtab shiftwidth=2 softtabstop=2 tabstop=8
augroup indentation_sr
  autocmd!
  autocmd Filetype python,c,haskell,markdown,rust,rst,kv,nginx,asm,nasm,gdscript3
        \ setlocal shiftwidth=4 softtabstop=4 tabstop=8 wrap
  autocmd Filetype dot setlocal autoindent cindent
  autocmd Filetype make,tsv,votl,go
        \ setlocal tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab
  " Prevent auto-indenting from occuring
  autocmd Filetype yaml setlocal indentkeys-=<:>
  autocmd FileType javascript set sw=2 ts=2 sts=2 wrap
  autocmd FileType json set sw=2 ts=2 sts=2
  autocmd FileType html set sw=2 ts=2 sts=2
  autocmd FileType css set sw=2 ts=2 sts=2
  autocmd FileType yaml set sw=2 ts=2 sts=2
  "autocmd FileType md set sw=2 ts=2 sts=2

  autocmd Filetype ron setlocal cindent
        \ cinkeys=0{,0},0(,0),0[,0],:,0#,!^F,o,O,e
        \ cinoptions+='(s,m2'
        \ cinoptions+='(s,U1'
        \ cinoptions+='j1'
        \ cinoptions+='J1'
augroup END

" }}}
" Limelight {{{
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)
"
" This will prevent :autocmd, shell and write commands from being
" run inside project-specific .vimrc files unless they’re owned by you.
set secure
" }}}
" fzf {{{
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
" }}}
" Preview {{{
function! s:preview()
  if &filetype ==? 'markdown'
    " from markdown-preview.vim
    exec 'MarkdownPreview'
  elseif &filetype ==? 'html'
    exec 'silent !google-chrome % &'
  else
    echo 'Preview not supported for this filetype'
  endif
endfunction

command! Preview call <SID>preview()
" }}}
" closetag {{{
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.vue,*.ts,*tsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,javascript,javascript.jsx,jsx,vue,typescript,typescript.tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive
" (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'javascript': 'jsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescript': 'jsxRegion,tsxRegion',
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
" }}}
" }}}
" Coc {{{
"
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> <C-]> <Plug>(coc-definition)
nnoremap <silent> <C-K> :call <SID>show_documentation()<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh() 

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Scroll in floating window
nnoremap <expr><C-e> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-e>"
nnoremap <expr><C-y> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-y>"

"let g:ale_completion_enabled = 1
"
" TO DO: Remove this when we fix neovim update issues
"let g:coc_disable_startup_warning = 1

" }}}
" Markdown {{{
" Notes:
" Hard-wrap lines: 'gq'
" Soft-wrap hard-wrapped lines: 'J' during visual selection

" Single Space After Punctuation: useful when doing :%j (the opposite of gq)
set nojoinspaces

" Indentation and line wrapping
autocmd FileType markdown
      \ setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=8 wrap linebreak nolist colorcolumn=0 nofoldenable

autocmd FileType markdown setlocal spell spelllang=en_gb

" MoveVisual: up and down visually only if count is specified before
" Otherwise, you want to move up lines numerically e.g. ignore wrapped lines
" note: gk and gj are visual moves supported in vim by default
nnoremap <expr> k
      \ v:count == 0 ? 'gk' : 'k'
vnoremap <expr> k
      \ v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j
      \ v:count == 0 ? 'gj' : 'j'
vnoremap <expr> j
      \ v:count == 0 ? 'gj' : 'j'

" J: basically, unmap in normal mode unless range explicitly specified
" This will prevent all sorts of annoyance
nnoremap <silent> <expr> J v:count == 0 ? '<esc>' : 'J'

" Plugin: vim-markdown
let g:vim_markdown_frontmatter = v:true
let g:vim_markdown_toml_frontmatter = v:true
let g:vim_markdown_json_frontmatter = v:true
let g:vim_markdown_no_default_key_mappings = v:true
let g:vim_markdown_strikethrough = v:true
let g:vim_markdown_folding_disabled = v:true
let g:vim_markdown_auto_insert_bullets = v:false
let g:vim_markdown_new_list_item_indent = v:false

" Plugin: bullets.vim
let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text',
      \ 'gitcommit',
      \ 'scratch',
      \ 'rst',
      \ ]

" Plugin: Markdown-preview.vim
" Gives you command :MarkdownPreview

let g:mkdp_auto_start = v:false
let g:mkdp_auto_close = v:false

" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = v:false

" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
" default: 0
let g:mkdp_command_for_global = v:false

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle'
      \ }
" }}}
