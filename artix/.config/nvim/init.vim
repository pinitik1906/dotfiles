colorscheme gruvbox
set bg=dark
set termguicolors
set number relativenumber
set encoding=utf-8
set clipboard+=unnamedplus
set ignorecase
set smartcase
syntax on

" copy
vnoremap  <C-c>  "+y

" paste
vnoremap <C-v> "+P

" markdown for calcurse
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
