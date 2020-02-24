" Don't use vi's defaults
set nocompatible

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
 autocmd FileType c,cpp,objc,cmake,yaml setlocal shiftwidth=2 softtabstop=2 expandtab cc=81
 autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab cc=80
 autocmd FileType gitcommit setlocal cc=73 spell
augroup END

