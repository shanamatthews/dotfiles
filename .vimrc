" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif



" --------------------------------- shana's additions -------------------------------

" increase the length of the vim buffer
" prevents truncated yanks, deletes, etc
set viminfo='20,<1000,s1000

" incremental search and case insensitive
set incsearch
set ic

set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set expandtab

syntax enable

autocmd FileType javascript setlocal equalprg=js-beautify\ --stdin
autocmd FileType sh set commentstring=#\ %s


" ------------------------------- ex-compatible settings -----------------------------
" activate line numbering
set number

" column and row position shown in bottom right
set ruler

" automatically indent lines
set autoindent

" automatically write files when multiple files open
set autowrite

" show command/insert mode
set showmode

" set tab size
set tabstop=2

" ignore case in regular expressions
set ignorecase

" highlight matching brackets/braces/parens
set showmatch

