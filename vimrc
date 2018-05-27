" ---------------------------------------------------------------------------
" System default settings
"  These are lifted from debian defaults (debian.vim). Set these explicityly
"  in case we are on a different plattform.
" ---------------------------------------------------------------------------
set nocompatible	" use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" General
" -------
Plug 'vimoutliner/vimoutliner'
Plug 'jamessan/vim-gnupg'
Plug 'scrooloose/nerdcommenter'
Plug 'jlanzarotta/bufexplorer'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" C/C++
Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
Plug 'vim-scripts/a.vim', { 'for' : ['c', 'cpp'] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for' : ['c','cpp'] }

" Rust
Plug 'rust-lang/rust.vim'

" LSP
" -----------------
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Themes
" ------
Plug 'tomasr/molokai'
Plug 'octol/vombatidae.vim'
Plug 'chriskempson/base16-vim'
Plug 'nanotech/jellybeans.vim'

" Initialize plugin system
call plug#end()

" ---------------------------------------------------------------------------
" Global editing settings
" ---------------------------------------------------------------------------
set clipboard=unnamed       " use X11 clipboard always
"set clipboard=autoselect,exclude:cons\|linux " default
"set textwidth=0            " 0 is the defaults, 72 linux kern, 79 python
"let g:loaded_matchparen = 1 " no loading of matchparen plugin (can be slow)
set showcmd                 " display incomplete commands

set incsearch               " do incremental searching
"set hlsearch
set linebreak
set scrolloff=2
set smartcase
set ignorecase

set hidden                  " background buffers can be unsaved
set autochdir
set novisualbell
set laststatus=2
set wildmode=longest,list,full
set wildmenu
set wildignore=*.o,*~,*.pyc,*.pyo,*.so

" ---------------------------------------------------------------------------
" Tabs
"  When using soft tabs (spaces) then we should set expandtab, shiftwidth,
"  softtabstop. Tabstop should be kept at 8.
"  When using hard tabs (^T) then we set tabstop and shiftwidth
" ---------------------------------------------------------------------------
set expandtab           " use spaces, not tabs
set shiftwidth=4        " indents of 4, e.g. < commands use this
set softtabstop=4
set shiftround          " round indent to nearest shiftwidth multiple

" ---------------------------------------------------------------------------
" Operational settings
" ---------------------------------------------------------------------------
if has("autocmd")
    filetype on
    filetype plugin on  " load settings for specific modes
    filetype indent on  " load indent settings for specific modes
endif
if !exists("syntax_on")
    syntax on
endif
if has('mouse')
    "set mouse=a
endif
set modeline            " so vim reads inline options in files

" Jump to last position when opening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set tags=./tags;/,tags;/

" ---------------------------------------------------------------------------
" Macros and keybindings
" ---------------------------------------------------------------------------
map <F4> :<C-U>call ToggleColor()<CR>
" Inserts date
inoremap <F5> <C-R>=strftime("%a, %d %b %Y %H:%M:%S %z")<CR>
"set pastetoggle=<F5>

" ---------------------------------------------------------------------------
" Color settings
"  Note, it seems t_Co=16 works fine in normal terminal as well.
"  For screen, some set screen-bce.
" ---------------------------------------------------------------------------
" Assume that the terminal background is dark.
set background=dark

" ---------------------------------------------------------------------------
" Language specific
"  Note, cino=g0 indents the public/private keywords in C++ classes.
"  sw=shiftwidth, et=expandtab, sts=softtabstop, ts=tabstop
" ---------------------------------------------------------------------------
let c_no_curly_error=1

au BufNewFile,BufRead *.plt set filetype=gnuplot
au BufNewFile,BufRead *.Config set filetype=xml
au BufNewFile,BufRead *.aspx set filetype=html

au FileType c set sw=4 sts=4 et cino=g0 tw=80
au FileType cpp set sw=4 sts=4 et cino=g0 tw=90
au FileType fortran set sw=3 sts=3 et
au FileType haskell set sw=2 sts=2 et
au FileType haskell map <F6> :GhcModCheckAsync<CR>
au FileType haskell map <F7> :GhcModType<CR>
au FileType haskell map <S-F7> :GhcModTypeClear<CR>
au FileType html set sw=2 sts=2 et
au FileType htmldjango set sw=2 sts=2 et
au FileType python set sw=4 sts=4 et
au FileType sql set sw=4 sts=4 et
au FileType tex imap <F2> <ESC>:w<cr><leader>ll
au FileType tex map <F2> :w<cr><leader>ll
au FileType tex set sw=4 sts=4 et
au FileType text setlocal tw=78
au FileType xhtml set sw=2 sts=2 et
au FileType xml setlocal foldmethod=syntax sw=2 sts=2 et foldlevel=99
au FileType cmake set sw=2 sts=2 et

" ---------------------------------------------------------------------------
" vim-lsp
" ---------------------------------------------------------------------------

if executable('clangd-7')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd-7',
        \ 'cmd': {server_info->['clangd-7']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })

endif

au BufRead,BufNewFile * setlocal signcolumn=yes

let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

" Autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Force refresh completion
imap <F8> <Plug>(asyncomplete_force_refresh)

" Keybindings
map <F7> :LspHover<CR>
map <S-F7> :pclose<CR>
nnoremap <leader>jd :LspDefinition<CR>

" ---------------------------------------------------------------------------
" Latex-suite
" ---------------------------------------------------------------------------
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'evince'

" ---------------------------------------------------------------------------
" clang-format
" ---------------------------------------------------------------------------
map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format-6.0.py<CR>
imap <C-K> <ESC>:py3f /usr/share/vim/addons/syntax/clang-format-6.0.py<CR>i

" ---------------------------------------------------------------------------
" vim-cpp-enhanced-hightlight
" ---------------------------------------------------------------------------
"let g:cpp_experimental_template_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_class_scope_highlight = 1

" ---------------------------------------------------------------------------
" vim-better-whitespace
" ---------------------------------------------------------------------------
let g:better_whitespace_filetypes_blacklist=['mail', 'tex', 'text']

" ---------------------------------------------------------------------------
" Fortran
" ---------------------------------------------------------------------------
let fortran_free_source = 1

" ---------------------------------------------------------------------------
" GUI specific settings
" ---------------------------------------------------------------------------
if has("gui_running")
    if has("gui_gtk2") || has("gui_gtk3")
        silent! colorscheme molokai
        "silent! set guifont=Droid\ Sans\ Mono\ 11
        silent! set guifont=Liberation\ Mono\ 13
        "silent! set guifont=Liberation\ Mono\ 11
        set guioptions-=m   " remove menubar
    elseif has("gui_win32")
        silent! colorscheme molokai
        silent! set guifont=Consolas:h11
        set lines=40 columns=120
        set diffexpr=MyDiff()
    endif
    set guioptions-=T	" remove icons
    set guioptions-=r   " remove right scrollbar
    set guioptions-=L   " remove left scrollbar
elseif &t_Co == 256
    " If we have 256 colors in the current terminal, set some nice theme
    silent! colorscheme molokai
    " Disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    "set t_ut=
end

" --------------------------------------------------------------------------
" Helper functions
" --------------------------------------------------------------------------
function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '""'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

function! ToggleColor()
    if &t_Co==8
        set t_Co=256
        colorscheme molokai
    else
        set t_Co=8
        colorscheme default
        set background=dark
    endif
endfunction
