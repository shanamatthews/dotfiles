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
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set autowrite          " automatically write files when multiple files opea
set autoread           " automaticlaly re-read in files that have been chanced

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" replace emojis
autocmd BufWritePost *.md silent !toemoji %

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

set norelativenumber   " this setting is stupid

" ------------------------------- text display -------------------------------

set display=lastline   " show as much of last line as possible
set scrolloff=2        " try to keep some buffer around the cursor

set number             " activate line numbering

set ruler              " column and row position shown in bottom right

set showmatch          " highlight matching brackets/braces/parens

" --------------------------------- text wrap --------------------------------

set wrap
set textwidth=72
set formatoptions=tcq  " this is the default, consider changing

" --------------------------------- indenting --------------------------------

set autoindent         " automatically indent lines

set tabstop=2          " set tab size

" autoindenting is smart when starting a new line
" not supported by all languages (maybe mostly just c)
set smartindent

set expandtab          " replace tabs with spaces

" I don't really know what this does, so leaving it off
set softtabstop=0

set shiftwidth=2       " this is for >> and <<

" makes it so you can delete your inserted spaces as if they were tabs
set smarttab

set shiftround         " Round indent to multiple of 'shiftwidth'

" --------------------------------- searching --------------------------------

set incsearch          " incremental search 
set ic                 " and case insensitive

set hlsearch           " Switch on highlighting the last used search pattern.

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

set termwinsize=12x0   " set terminal pane size (?? shana doesn't know what these #s refer to)
set splitbelow         " always split terminal below (?? shana doesn't really get this either)

" --------------------------------- commands ---------------------------------

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Do not show stupid q: window
map q: :q

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

" disable arrow keys BECAUSE I HATE MYSELF
noremap <up> :echoerr "Be a good vimmer, use k"
noremap <down> :echoerr "Be a good vimmer, use j"
noremap <left> :echoerr "Be a good vimmer, use h"
noremap <right> :echoerr "Be a good vimmer, use l"
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>

" ---------------------------- filetype specifics ----------------------------

autocmd FileType javascript setlocal equalprg=js-beautify\ --stdin
autocmd FileType sh set commentstring=#\ %s

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

" only load plugins if Plug is available
" don't forget to :PlugInstall (in vim) to install plugins
if filereadable(expand("~/.vim/autoload/plug.vim"))

  " junegunn/vim-plug
  call plug#begin('~/.local/share/vim/plugins')

  " plugins go here
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'sheerun/vim-polyglot'
  Plug 'jez/vim-better-sml'
  Plug 'preservim/nerdtree'

  call plug#end()

  " plugin customization
  " disable pandoc folding
  let g:pandoc#modules#disabled = ["folding"]

endif

" Options for plugins
autocmd VimEnter * NERDTree    " Start NerdTree on startup & leave cursor in it
