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
" Vundle
"  Setup plugins
"  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" ---------------------------------------------------------------------------
if has("autocmd")
    filetype off
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " General
    Bundle 'gmarik/vundle'
    Bundle 'vimoutliner/vimoutliner'
    Bundle 'gnupg.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    "Bundle 'scrooloose/syntastic'
    Bundle 'kien/ctrlp.vim'
    Bundle 'bufexplorer.zip'
    "Bundle 'nerdcommenter'
    Bundle 'Tagbar'
    Bundle 'bling/vim-airline'
    "Bundle 'Valloric/YouCompleteMe'
    Bundle 'rking/ag.vim'
    "Bundle 'mileszs/ack.vim'

    " Language specific
    Bundle 'a.vim'
    Bundle 'othree/html5-syntax.vim'
    Bundle 'hdima/python-syntax'
    Bundle 'pangloss/vim-javascript'
    Bundle 'vim-jp/cpp-vim'
    Bundle 'octol/vim-cpp-enhanced-highlight'
    Bundle 'wting/rust.vim'
    
    " Themes
    Bundle 'tomasr/molokai'
    Bundle 'octol/vombatidae.vim'
    Bundle 'chriskempson/base16-vim'
    Bundle 'xoria256.vim'
endif

" ---------------------------------------------------------------------------
" Configuration specific to mswin
" ---------------------------------------------------------------------------
"if has("win32")
"    behave mswin
"endif

" ---------------------------------------------------------------------------
" Global editing settings
" ---------------------------------------------------------------------------
set clipboard=unnamed       " use X11 clipboard always
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
"if has('mouse')
"    set mouse=a
"endif
set modeline            " so vim reads inline options in files

" Jump to last position when opening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ---------------------------------------------------------------------------
" Macros and keybindings
" ---------------------------------------------------------------------------
" Inserts date
inoremap <F6> <C-R>=strftime("%a, %d %b %Y %H:%M:%S %z")<CR>
set pastetoggle=<F5>
map <F7> :<C-U>call ToggleColor()<CR>
inoremap <F8> <C-r>=substitute(substitute(system("uuidgen"), '-', '_', 'g'), '.$', '', 'g')<CR>

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
"let g:xml_syntax_folding=1
"let sh_fold_enabled=1
"set foldmethod=syntax

if has("autocmd")
    au BufNewFile,BufRead *.plt set filetype=gnuplot
    au BufNewFile,BufRead *.Config set filetype=xml
    au BufNewFile,BufRead *.aspx set filetype=html

    au FileType tex set sw=4 ts=4 noet tw=76 
    au FileType tex map <F2> :w<cr><leader>ll
    au FileType tex imap <F2> <ESC>:w<cr><leader>ll
    au FileType xhtml set sw=2 sts=2 et
    au FileType html set sw=2 sts=2 et
    au FileType htmldjango set sw=2 sts=2 et
    au FileType python set sw=4 sts=4 et
    au FileType fortran set sw=3 sts=3 et
    au FileType text setlocal tw=78
    au FileType cpp set sw=4 sts=4 et cino=g0 tw=76 
    au FileType delphi set ignorecase
    au FileType xml setlocal foldmethod=syntax sw=2 sts=2 et foldlevel=99
    au FileType sql set sw=4 sts=4 et

    " Highlight characters over column 80
    "au BufWinEnter *.{m,tex,c,cpp,h} let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
    "au BufWinEnter *.{m,tex,c,cpp,h} let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
   
    " Don't ignore trailing whitespace 
    "highlight WhiteSpaceEOL ctermbg=white guibg=red
    "au BufWinEnter *.{c,cpp,cxx,h,hpp} match WhiteSpaceEOL /\s\+$/
endif

" --------------------------------------------------------------------------
" Spelling
"  Overide the colors for spelling, so that we see them. This is a workaround
"  for some themes.
" --------------------------------------------------------------------------
"hi SpellBad term=reverse ctermfg=white ctermbg=darkred guifg=#ffffff guibg=#7f0000 gui=underline
"hi SpellCap guifg=#ffffff guibg=#7f007f
"hi SpellRare guifg=#ffffff guibg=#00007f gui=underline
"hi SpellLocal term=reverse ctermfg=black ctermbg=darkgreen guifg=#ffffff guibg=#7f0000 gui=underline

" --------------------------------------------------------------------------
" NERDTree plugin
" --------------------------------------------------------------------------
let NERDTreeIgnore=['\.lo$','\.o$','\.gcda$','\.gcno$']
map <F2> :NERDTreeToggle<CR>

" --------------------------------------------------------------------------
" Tagbar plugin
" --------------------------------------------------------------------------
map <F3> :TagbarToggle<CR>

" ---------------------------------------------------------------------------
" YouCompleteMe
" ---------------------------------------------------------------------------
let g:ycm_extra_conf_globlist = ['~/devel/*','~/Documents/*']

" ---------------------------------------------------------------------------
" Latex-suite
" ---------------------------------------------------------------------------
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'evince'

" ---------------------------------------------------------------------------
" Airline
" ---------------------------------------------------------------------------
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
let g:airline_right_sep = ' '
"let g:airline_right_alt_sep = ''


" ---------------------------------------------------------------------------
" clang-format
" ---------------------------------------------------------------------------
map <C-K> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
imap <C-K> <ESC>:pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>i

" ---------------------------------------------------------------------------
" GUI specific settings
" ---------------------------------------------------------------------------
if has("gui_running")
    if has("gui_gtk2")
        silent! colorscheme molokai
        silent! set guifont=Droid\ Sans\ Mono\ 11
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

