" ---------------------------------------------------------------------------
" System default settings
"  These are lifted from debian defaults (debian.vim). Set these explicityly
"  in case we are on a different platform.
" ---------------------------------------------------------------------------
set nocompatible        " use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" Set the leader for use on layouts where the default backslash is
" inconvenient
let mapleader=','

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------
if !has("compatible")
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    " Specify a directory for plugins
    " - Avoid using standard Vim directory names like 'plugin'
    call plug#begin('~/.vim/plugged')

    " General
    " -------
    Plug 'vimoutliner/vimoutliner'
    Plug 'jamessan/vim-gnupg'
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'majutsushi/tagbar'
    "Plug 'itchyny/lightline.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'ntpeters/vim-better-whitespace'
    "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    "Plug 'junegunn/fzf.vim'
    Plug 'mtdl9/vim-log-highlighting'
    Plug 'mhinz/vim-grepper'
    "Plug 'airblade/vim-gitgutter'
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating'
    "Plug 'plasticboy/vim-markdown'
    Plug 'tpope/vim-markdown'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'inkarkat/diff-fold.vim'
    Plug 'cespare/vim-toml', { 'branch': 'main' }

    " C/C++
    Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
    Plug 'vim-scripts/a.vim', { 'for' : ['c', 'cpp'] }
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for' : ['c','cpp'] }

    " Rust
    Plug 'rust-lang/rust.vim'
    "Plug 'arzg/vim-rust-syntax-ext'

    " Fish shell
    Plug 'Stautob/vim-fish'

    " Themes
    " ------
    Plug 'tomasr/molokai'
    Plug 'octol/vombatidae.vim'
    Plug 'chriskempson/base16-vim'
    Plug 'nanotech/jellybeans.vim'
    "Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'arzg/vim-colors-xcode'

    " Initialize plugin system
    call plug#end()
endif

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
set novisualbell
set laststatus=2
set wildmode=longest,list,full
set wildmenu
set wildignore=*.o,*~,*.pyc,*.pyo,*.so
"if !has("compatible")
    "set autochdir
"endif

set breakindent             " indent wrapped lines to preserve indendation
"set showbreak=--------      " additional indent when wrapping lines
set linebreak               " soft-wrap only at certain characters
set nojoinspaces            " don't do double spaces after '.'

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
    set mouse=a
endif
set modeline            " so vim reads inline options in files

" Jump to last position when opening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set tags=./tags;/,tags;/
set directory=~/tmp,/var/tmp,/tmp

let g:netrw_banner = 0
let g:netrw_liststyle= 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

" Use tab for autocompletion
"inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"

" ---------------------------------------------------------------------------
" Macros and keybindings
" ---------------------------------------------------------------------------
map <F4> :<C-U>call ToggleColor()<CR>
" Inserts date
inoremap <F5> <C-R>=strftime("%a, %d %b %Y %H:%M:%S %z")<CR>
"set pastetoggle=<F5>

" Filter buffer
" manually its:
"   %y z|tabnew|0put=@z|%!grep -n
" or
"   :vimgrep pattern %
"   :cwin
:command! -nargs=1 -range=% Filter <line1>,<line2>y z|tabnew|0put=@z|%!grep -n '<q-args>'

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
au FileType c,cpp,rust set showbreak=--------
au FileType fortran set sw=3 sts=3 et
au FileType haskell set sw=2 sts=2 et
au FileType haskell map <F6> :GhcModCheckAsync<CR>
au FileType haskell map <F7> :GhcModType<CR>
"au FileType haskell map <S-F7> :GhcModTypeClear<CR>
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
"au FileType rust nnoremap <silent> <C-K> :RustFmt<CR>
"au FileType rust set noexpandtab tabstop=4 shiftwidth=4

" ---------------------------------------------------------------------------
" Nerdtree plugin
" ---------------------------------------------------------------------------
map <F2> :NERDTreeToggle<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

" ---------------------------------------------------------------------------
" Tagbar plugin
" ---------------------------------------------------------------------------
map <F3> :TagbarToggle<CR>
let g:tagbar_sort = 0

" ---------------------------------------------------------------------------
" Latex-suite
" ---------------------------------------------------------------------------
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'evince'

" ---------------------------------------------------------------------------
" clang-format
" ---------------------------------------------------------------------------
au FileType c,cpp map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format.py<CR>
au FileType c,cpp imap <C-K> <ESC>:py3f /usr/share/vim/addons/syntax/clang-format.py<CR>i

" ---------------------------------------------------------------------------
" vim-cpp-enhanced-hightlight
" ---------------------------------------------------------------------------
"let g:cpp_experimental_template_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_class_scope_highlight = 1

" ---------------------------------------------------------------------------
" vim-better-whitespace
" ---------------------------------------------------------------------------
let g:better_whitespace_filetypes_blacklist=['mail', 'tex', 'text', 'log']

" ---------------------------------------------------------------------------
" Fortran
" ---------------------------------------------------------------------------
let fortran_free_source = 1

" ---------------------------------------------------------------------------
" vim-fzf
" ---------------------------------------------------------------------------
"nnoremap <c-p> :GitFiles<cr>

" ---------------------------------------------------------------------------
" telescope
" ---------------------------------------------------------------------------

nnoremap <c-p> <cmd>Telescope git_files<cr>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ---------------------------------------------------------------------------
" airline
" ---------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
"let g:airline#extensions#hunks#enabled = 0

" Remove git branch
let g:airline_section_b = ''
" Remove file encoding
let g:airline_section_y = ''
" Remove separators for empty sections
let g:airline_skip_empty_sections = 1

" ---------------------------------------------------------------------------
" vim-markdown
" ---------------------------------------------------------------------------

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
"let g:vim_markdown_conceal = 0

" disable math tex conceal feature
"let g:tex_conceal = ""
"let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

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
    set guioptions-=T   " remove icons
    set guioptions-=r   " remove right scrollbar
    set guioptions-=L   " remove left scrollbar
elseif &t_Co == 256
    " If we have 256 colors in the current terminal, set some nice theme
    silent! colorscheme molokai
    " Disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    "set t_ut=
    " Use 24-bit colors
    set termguicolors
end

" --------------------------------------------------------------------------
" Helper functions
" --------------------------------------------------------------------------
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
