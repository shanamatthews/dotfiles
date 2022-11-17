set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" ------------------------------- plugin config ------------------------------
" telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" catppuccin
colorscheme catppuccin-mocha

" --------------------------------- lua stuff --------------------------------
source $HOME/.config/nvim/lua.stuff.vim
