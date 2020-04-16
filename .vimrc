" Most of the settings come from Nikos Skalkotos .vimrc

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" Detect files
filetype on

" Set spelling language to English
set spell spelllang=en_us

" Enable spelling on git commit
augroup spelling
 autocmd! FileType gitcommit setlocal spell
augroup END

" Fix spell highlighting on comments
highlight SpellBad ctermfg=0

" Customize presentation of file types
augroup identation
 autocmd!
 autocmd FileType c,cpp,objc,cmake,yaml setlocal shiftwidth=2 softtabstop=2 expandtab cc=81 number
 autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab cc=80 number
 autocmd FileType gitcommit setlocal cc=73 spell
augroup END

" Add mouse support
set mouse=a

" Open new split panes to right and bottom, which feels more natural:
set splitbelow
set splitright

" turn syntax highlighting on
syntax on

" turn line numbers on
set number

" setup vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" NERDTree
Plug 'preservim/nerdtree'

call plug#end()

" Shortcuts

" set the lead character to space
let mapleader = " "

" next buffer
nnoremap <leader>n :bn<CR>

" previous buffer
nnoremap <leader>p :bp<CR>

" delete current buffer
nnoremap <leader>x :bd<CR>

" set NERDTree shortcut
noremap <leader><tab> :NERDTreeToggle<CR>
