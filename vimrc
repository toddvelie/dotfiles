set t_Co=256
set nocompatible
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Default to tree mode
let g:netrw_liststyle=3

" Change directory to the current buffer when opening files.
set autochdir

"Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/Vundle.vim'

Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'altercation/vim-colors-solarized'


call vundle#end()
filetype plugin indent on

" Personalize!
inoremap jk <ESC>
let mapleader = ","
syntax enable
set background=dark
colorscheme solarized
set encoding=utf-8
set number
filetype indent on
set ignorecase
set ruler
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set nowrap
let g:mustache_abbreviations = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" Yank text to OS clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
" Preserve indentation while pasting from the OS clipboard
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>
