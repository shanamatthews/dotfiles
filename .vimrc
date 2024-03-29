" ------------------------------ vim settings!!! -----------------------------

" vi compatibility - ironically (??) this option is not compatible with vi :P
" and is also kind of just a lie and actually supports lots of stuff vi doesn't
" actually there's no point in turning this on because it's not compatible
set nocompatible

" ------------------------------- backups/saves ------------------------------

if has("vms")
  set nobackup		     " do not keep a backup file, use versions instead
else
  set backup		       " keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	     " keep an undo file (undo changes after closing)
  endif
endif

set noswapfile         " we don't need this annoying thing

set undodir=~/.vim/.undo//
set undofile
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set autowrite          " automatically write files when multiple files opea
set autoread           " automaticlaly re-read in files that have been chanced

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" replace emojis
" autocmd BufWritePost *.md silent !toemoji %

" opening a new file with unsaved changes just hides current file
set hidden

" ------------------------------ buffer, history -----------------------------

" increase the length of the vim buffer
" prevents truncated yanks, deletes, etc
set viminfo='20,<1000,s1000

set history=200		     " keep 200 lines of command line history

" -------------------------- menus, command displays -------------------------

set showcmd		         " display incomplete commands
set wildmenu		       " display completion matches in a status line

set ttimeout		       " time out for key codes
set ttimeoutlen=100	   " wait up to 100ms after Esc for special key

set showmode           " show command/insert mode

" ------------------------------- text display -------------------------------

set display=lastline   " show as much of last line as possible
set scrolloff=4        " try to keep some buffer around the cursor

set number             " activate line numbering
set relativenumber     " so we have numbers and relative numbers

set ruler              " column and row position shown in bottom right

set showmatch          " highlight matching brackets/braces/parens

set signcolumn         " add a left gutter for linting info

" --------------------------------- text wrap --------------------------------

set wrap
set textwidth=72
set formatoptions=tcq  " this is the default, consider changing

" --------------------------------- indenting --------------------------------

set autoindent         " automatically indent lines

" autoindenting is smart when starting a new line
" not supported by all languages (maybe mostly just c)
set smartindent

set expandtab          " replace tabs with spaces
set tabstop=2          " set tab size
set softtabstop=2 " I don't really know what this does
set shiftwidth=2       " this is for >> and <<

" makes it so you can delete your inserted spaces as if they were tabs
set smarttab

set shiftround         " Round indent to multiple of 'shiftwidth'

" --------------------------------- searching --------------------------------

set incsearch          " incremental search
set ic                 " and case insensitive

set nohlsearch           " Switch on highlighting the last used search pattern.

set ignorecase         " ignore case in regular expressions
set smartcase          " exept when we've used a capital letter explicitly

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" -------------------------------- mouse stuff -------------------------------

" If linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux" && !has('nvim')
  set ttymouse=xterm
endif

" trying to add these to make tmux mouse stuff work better
" (spoiler alert, didn't work)
" set ttymouse=xterm
" set mouse=a

" -------------------------------- shell pane --------------------------------

" set termwinsize=12x0   " set terminal pane size (?? shana doesn't know what these #s refer to)
set splitbelow         " always split terminal below (?? shana doesn't really get this either)

" ctrl + s opens shell
map <silent> <C-s> :terminal<CR>
" ctrl + t goes through tabs
map <silent> <C-t> :tabn<CR>

" --------------------------------- commands ---------------------------------

" set leader key
nnoremap <SPACE> <Nop>
let mapleader = " "

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Do not show stupid q: window
noremap q: :q

" make & consistent with D and C (yank until the eol)
nnoremap Y y$

syntax enable
let c_comment_strings=1 " I like highlighting strings inside C comments.

" Command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" disable arrow keys
noremap <up> :echoerr "Be a good vimmer, use k"
noremap <down> :echoerr "Be a good vimmer, use j"
noremap <left> :echoerr "Be a good vimmer, use h"
noremap <right> :echoerr "Be a good vimmer, use l"
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>

" navigate with ctrl + directions, instead of ctrl + w + direction
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" ------------------------------ tab completion ------------------------------

" imap <Tab> <C-P> " this was cursed
" imap <Tab> <C-N> " this is C-P backwards
" https://thoughtbot.com/blog/vim-you-complete-me

:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ---------------------------- filetype specifics ----------------------------

autocmd FileType javascript setlocal equalprg=js-beautify\ --stdin
autocmd FileType sh set commentstring=#\ %s

" Shana doesn't know exactly what this does, but needed for vimwiki
filetype plugin on

" ---------------------------------- linting ---------------------------------

" set pylint linter for python files
" autocmd FileType python compiler pylint

" automatically execute :make on file write
" autocmd BufWritePost *.py,*.js silent make! <afile> | silent redraw!

" automatically open the quickfix window
" autocmd QuickFixCmdPost [^l]* cwindow

" using ALElint
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'python': ['pylint']
\}

let g:ale_sign_error = '!'
let g:ale_sign_warning = '*'

let g:ale_set_highlights = 0
highlight clear ALEErrorSign
highlight clear ALEWarningSign

" work with airline
let g:airline#extensions#ale#enabled = 1

" lint only on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" Disable auto-detection of virtualenvironments
let g:ale_virtualenv_dir_names = []
" Environment variable ${VIRTUAL_ENV} is always used

" ----------------------------------- panes ----------------------------------

" idk what this does, so removing it
" map <silent> <leader>pp :vsp<CR>

set splitbelow
set splitright

" switch buffers with tab
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" ---------------------------------- plugins ---------------------------------

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" autoinstall Plug
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" autoinstall any plugins that aren't installed
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" only load plugins if Plug is available
if filereadable(expand("~/.vim/autoload/plug.vim"))

  " junegunn/vim-plug
  call plug#begin('~/.local/share/vim/plugins')

  " if using nvim, also add nvim stuff
  if has ('nvim')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'catppuccin/nvim'
  endif

  " plugins go here
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'sheerun/vim-polyglot'
  Plug 'jez/vim-better-sml'
  Plug 'preservim/nerdtree'
  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown'
  Plug 'dense-analysis/ale'
  Plug 'vim-airline/vim-airline'
  Plug 'mbbill/undotree'

  call plug#end()

  " plugin customization

  " disable pandoc folding
  let g:pandoc#modules#disabled = ["folding"]

  " Nerdtree shows hidden files
  let NERDTreeShowHidden=1

  " Airline
  let g:airline#extensions#tabline#enabled = 1 " buffer list

endif

" Options for plugins

" NerdTree
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <leader>nf :NERDTreeFocus<cr>
noremap <silent> <leader>nn :NERDTreeToggle<CR>

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Undo tree
nnoremap <leader>ut :UndotreeToggle<CR>



" ------------------------------ omnicompletion ------------------------------

" these broke everything somehow
" filetype plugin on
" set omnifunc=syntaxcomplete#Complete

