" Most of the settings come from Nikos Skalkotos .vimrc

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

" Some servers have issues with backup files, see #649 (coc)
set nobackup
set nowritebackup

" give more space for displaying messages (coc)
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience (coc)
set updatetime=300

" Don't pass messages to |ins-completion-menu| (coc)
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved (coc)
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate (coc)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion (coc)
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rr <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,ruby,eruby setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
" highlight SpellBad ctermfg=0
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

" vim-ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" Automatically add 'end' when opening a block
Plug 'tpope/vim-endwise'

" ale linter
Plug 'dense-analysis/ale'

" vim fugitive
Plug 'tpope/vim-fugitive'

" Language Server support (currently solargraph)
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

call plug#end()

" Set rubocop liter at ale
let g:ale_linters = { 'ruby': ['rubocop'], }
let g:ale_linters_explicit = 1

" Set rubocop fixer at ale
let g:ale_fixers = { 'ruby': ['rubocop'], }
let g:ale_fixers_explicit = 1

" Disable ale auto highlights
let g:ale_set_highlights = 0

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

" delete current buffer
nnoremap <leader>x :bd<CR>

" force delete current buffer
nnoremap <leader>X :bd!<CR>

" set NERDTree shortcut
noremap <leader><tab> :NERDTreeToggle<CR>

" toggle spell checking
noremap <silent> <F5> :set spell!<CR>

" toggle tagbar
noremap <F8> :TagbarToggle<CR>
