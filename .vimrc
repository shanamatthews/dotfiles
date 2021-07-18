" ----------------------------- high-level behavior ---------------------------------
" vi compatibility - ironically (??) this option is not compatible with vi :P
" and is also kind of just a lie and actually supports lots of stuff vi doesn't
" actually there's no point in turning this on because it's not compatible
set nocompatible

" increase the length of the vim buffer
" prevents truncated yanks, deletes, etc
set viminfo='20,<1000,s1000

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set history=200		" keep 200 lines of command line history
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" automatically write files when multiple files open
set autowrite

" show command/insert mode
set showmode

" ----------------------------- display ---------------------------------
set display=lastline " show as much of last line as possible
set scrolloff=5 " try to keep some buffer around the cursor

" activate line numbering
set number

" column and row position shown in bottom right
set ruler

" highlight matching brackets/braces/parens
set showmatch

" ----------------------------- indenting ---------------------------------
" automatically indent lines
set autoindent

" set tab size
set tabstop=2

" autoindenting is smart when starting a new line
" not supported by all languages (maybe mostly just c)
set smartindent

" replace tabs with spaces
set expandtab

" I don't really know what this does, so leaving it off
set softtabstop=0

" this is for >> and <<
set shiftwidth=2   

" makes it so you can delete your inserted spaces as if they were tabs
set smarttab

" ----------------------------- searching ---------------------------------
" incremental search and case insensitive
set incsearch
set ic

" Switch on highlighting the last used search pattern.
set hlsearch

" ignore case in regular expressions
set ignorecase

" ----------------------------- commands ---------------------------------
" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Do not show stupid q: window
map q: :q

" Act like D and C
nnoremap Y y$

" If I'm trying to use my mouse, let me use my damn mouse
set mouse=a

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

" ----------------------------- filetype specifics ---------------------------------

autocmd FileType javascript setlocal equalprg=js-beautify\ --stdin
autocmd FileType sh set commentstring=#\ %s

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" ----------------------------- optional packages ---------------------------------

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

