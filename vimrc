" Fix printing strange characters (>4;2m) (:help modifyOtherKeys for more)
let &t_TI = ""
let &t_TE = ""

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" allow 'normal' backspace usage
set backspace=indent,eol,start

" allow opening new buffer when the current one is not saved
set hidden

" Enable folding
set foldmethod=indent
set foldlevel=99

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" Detect files
filetype on

" Set spelling language to English
set spell spelllang=en_us

" Disable spelling by default
set nospell

" Set dark background so that the color groups get adjusted
" (necessary for making highlighting work in tmux)
set background=dark

" Enable spelling on git commit
augroup spelling
 autocmd! FileType gitcommit setlocal spell
augroup END

" Fix spell highlighting on comments
highlight SpellBad ctermfg=0
highlight SpellLocal ctermfg=0

" Customize presentation of file types
augroup identation
 autocmd!
 autocmd FileType c,cpp,objc,cmake,yaml,ruby,eruby,scss setlocal shiftwidth=2 softtabstop=2 expandtab cc=81 number
 autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab cc=80 number
 autocmd FileType gitcommit setlocal cc=73 spell
augroup END

" Add mouse support
set mouse=a

" Only display the minimized filename when minimizing with <C-W>_
set winminheight=0

" Open new split panes to right and bottom, which feels more natural:
set splitbelow
set splitright

" python highlighting
let python_highlight_all=1

" turn syntax highlighting on
syntax on

" turn line numbers on
set number

" highlight matching braces
set showmatch

" setup vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" NERDTree
Plug 'preservim/nerdtree'

" fzf fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Airline decorates the statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" tagbar will show the code tag (class name, function name) in the statusbar
Plug 'majutsushi/tagbar'

" ale linter
Plug 'dense-analysis/ale'

" vim fugitive
Plug 'tpope/vim-fugitive'

" gitgutter
Plug 'airblade/vim-gitgutter'

" below function is needed for ycm:
"function! BuildYCM(info)
"  if a:info.status == 'installed' || a:info.force
"    !./install.py
"  endif
"endfunction

" ycm
"Plug 'ycm-core/YouCompleteMe', { 'branch': 'legacy-py2', 'do': function('BuildYCM') }

" syntastic
Plug 'scrooloose/syntastic'

" PEP8 linter
Plug 'nvie/vim-flake8'

" vim-bbye (kill buffer without messing-up splits
Plug 'moll/vim-bbye'

" ruanyl/vim-gh-line (open line in github)
Plug 'ruanyl/vim-gh-line'

call plug#end()

" Disable ale auto highlights
let g:ale_set_highlights = 0

" vim-gh-line copy GH URL instead of opening it
let g:gh_open_command = 'fn() { echo "$@" | xclip -selection clipboard; }; fn '

" For vim-airline

" Remove VCS imformation
let g:airline_section_b = ""

" Only display the filename. Not the full path
let g:airline_section_c = '%t'

" Remove filetype section
let g:airline_section_y = ""

" Usa a pretty theme
let g:airline_theme = "papercolor"

" Enable the tab line (open tabs on the top)
let g:airline#extensions#tabline#enabled = 1

" Show only the filename in the tabline
let g:airline#extensions#tabline#fnamemod = ':t'

" Add mapping for opening tabs
"let g:airline#extensions#tabline#buffer_idx_mode = 1

" Show buffer numbers
let g:airline#extensions#tabline#buffer_nr_show = 1

" Enable tagbar integration
let g:airline#extensions#tagbar#enabled = 1

" Display the full hierarchy of the tag, not just the tag itself.
let g:airline#extensions#tagbar#flags = 'f'

" Remove word counting (we are not journalists)
let g:airline#extensions#wordcount#enabled = 0

" Shortcuts

" set the lead character to space
let mapleader = " "

" next buffer
nnoremap <leader>n :bn<CR>

" previous buffer
nnoremap <leader>p :bp<CR>

" delete current buffer (plugin: moll/vim-bbye)
" nnoremap <leader>x :bd<CR>
 nnoremap <leader>x :Bdelete<CR>

" force delete current buffer (plugin: moll/vim-bbye)
" nnoremap <leader>X :bd!<CR>
nnoremap <leader>X :Bdelete!<CR>

" set NERDTree shortcut
noremap <leader><tab> :NERDTreeToggle<CR>

" toggle spell checking
noremap <silent> <F5> :set spell!<CR>

" toggle tagbar
noremap <F8> :TagbarToggle<CR>

"split navigations (use ctrl + [HJKL] for navigating splits)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"ctrl+k to Files
nnoremap <leader>k :Files<CR>

" ycm stuff
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" code folding
nnoremap <leader>, za
