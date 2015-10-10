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
" NeoVundle
"  Setup plugins
"  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
" ---------------------------------------------------------------------------

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" General
" -------
NeoBundle 'vimoutliner/vimoutliner'
NeoBundle 'gnupg.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'jlanzarotta/bufexplorer'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'bling/vim-airline'
NeoBundle 'rking/ag.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'junkblocker/patchreview-vim'
NeoBundle 'Shougo/vimproc.vim', { 'build' : { 'linux' : 'make' }}

" Language specific
" -----------------
NeoBundleLazy 'scrooloose/syntastic', { 'autoload' : { 'filetypes' : ['rust','haskell']}}
if v:version > 703 || (v:version == 703 && has('patch584'))
    NeoBundleLazy 'Valloric/YouCompleteMe', {
        \ 'autoload' : { 'filetypes' : ['rust','c','cpp','haskell'] } }
endif

" C/C++
NeoBundleLazy 'a.vim', { 'autoload' : { 'filetypes' : ['c','cpp'] }}
NeoBundleLazy 'vim-jp/cpp-vim', { 'autoload' : { 'filetypes' : ['c','cpp'] }}
NeoBundleLazy 'octol/vim-cpp-enhanced-highlight', { 'autoload' : { 'filetypes' : ['c','cpp'] }}
"NeoBundleLazy 'mizuchi/STL-Syntax', { 'autoload' : { 'filetypes' : ['c','cpp'] }}
"NeoBundleLazy 'bbchung/clighter', { 'autoload' : { 'filetypes' : ['c','cpp'] }}
"NeoBundleLazy 'jeaye/color_coded', {
"      \ 'build': {
"      \   'unix': 'cmake . && make && make install',
"      \ },
"      \ 'autoload' : { 'filetypes' : ['c', 'cpp', 'objc', 'objcpp'] },
"      \ 'build_commands' : ['cmake', 'make']
"  \}

" Rust
NeoBundleLazy 'rust-lang/rust.vim', { 'autoload' : { 'filetypes' : 'rust' }}
NeoBundleLazy 'phildawes/racer', { 'autoload' : { 'filetypes' : 'rust' }}

" Haskell
NeoBundleLazy 'eagletmt/ghcmod-vim', { 'autoload' : { 'filetypes' : 'haskell' }}
NeoBundleLazy 'travitch/hasksyn', { 'autoload' : { 'filetypes' : 'haskell' }}
NeoBundleLazy 'eagletmt/neco-ghc', { 'autoload' : { 'filetypes' : 'haskell' }}
NeoBundleLazy 'octol/vim-hindent', { 'autoload' : { 'filetypes' : 'haskell' }}
"NeoBundleLazy 'dag/vim2hs', { 'autoload' : { 'filetypes' : 'haskell' }}
"NeoBundleLazy 'lukerandall/haskellmode-vim', { 'autoload' : { 'filetypes' : 'haskell' }}
"NeoBundleLazy 'bitc/vim-hdevtools', { 'autoload' : { 'filetypes' : 'haskell' }}

" Web
NeoBundleLazy 'othree/html5.vim', { 'autoload' : { 'filetypes' : 'html' }}
NeoBundleLazy 'pangloss/vim-javascript', { 'autoload' : { 'filetypes' : 'javascript' }}

" Misc
NeoBundleLazy 'tpope/vim-markdown', { 'autoload' : { 'filetypes' : 'markdown' }}
NeoBundleLazy 'hdima/python-syntax', { 'autoload' : { 'filetypes' : 'python' }}

" Themes
" ------
NeoBundle 'tomasr/molokai'
NeoBundle 'octol/vombatidae.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'xoria256.vim'
NeoBundle 'nanotech/jellybeans.vim'

call neobundle#end()

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
set foldmethod=indent

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
"let g:xml_syntax_folding=1
"let sh_fold_enabled=1
"set foldmethod=syntax

if has("autocmd")
    au BufNewFile,BufRead *.plt set filetype=gnuplot
    au BufNewFile,BufRead *.Config set filetype=xml
    au BufNewFile,BufRead *.aspx set filetype=html

    au FileType c set sw=4 sts=4 et cino=g0 tw=80
    au FileType cpp set sw=4 sts=4 et cino=g0 tw=90
    au FileType c,cpp inoremap <F6>
        \ <C-r>=substitute(substitute(system("uuidgen"), '-', '_', 'g'), '.$', '', 'g')<CR>
    au FileType delphi set ignorecase
    au FileType fortran set sw=3 sts=3 et
    au FileType haskell set sw=2 sts=2 et
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

    " Highlight characters over column 80
    "au BufWinEnter *.{m,tex,c,cpp,h} let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
    "au BufWinEnter *.{m,tex,c,cpp,h} let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

    " Don't ignore trailing whitespace
    "highlight WhiteSpaceEOL ctermbg=white guibg=red
    "au BufWinEnter *.{c,cpp,cxx,h,hpp,mk,patch} match WhiteSpaceEOL /\s\+$/
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
let g:ycm_extra_conf_globlist = ['~/workspace/*']
nnoremap <leader>jd :YcmCompleter GoTo<CR>
set completeopt-=preview
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" ---------------------------------------------------------------------------
" vim2hs
" ---------------------------------------------------------------------------

"let g:haskell_conceal_wide = 1

" disable all conceals, including the simple ones like
" lambda and composition
"let g:haskell_conceal              = 0

" disable concealing of "enumerations": commatized lists like
" deriving clauses and LANGUAGE pragmas,
" otherwise collapsed into a single ellipsis
"let g:haskell_conceal_enumerations = 0

" ---------------------------------------------------------------------------
" Latex-suite
" ---------------------------------------------------------------------------
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'evince'

" ---------------------------------------------------------------------------
" Syntastic
" ---------------------------------------------------------------------------
let g:syntastic_always_populate_loc_list = 1

" ---------------------------------------------------------------------------
" Airline
" ---------------------------------------------------------------------------
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#syntastic#enabled = 1

" When patched fonts not available
let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
let g:airline_right_sep = ' '
"let g:airline_right_alt_sep = ''

" Only used when patched fonts available
"let g:airline_powerline_fonts = 1

" ---------------------------------------------------------------------------
" CtrlP
" ---------------------------------------------------------------------------
let g:ctrlp_root_markers = ['.ctrlp']
" Call out to Ag for performance
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ---------------------------------------------------------------------------
" clang-format
" ---------------------------------------------------------------------------
map <C-K> :pyf /usr/share/vim/addons/syntax/clang-format-3.6.py<CR>
imap <C-K> <ESC>:pyf /usr/share/vim/addons/syntax/clang-format-3.6.py<CR>i

" ---------------------------------------------------------------------------
" vim-cpp-enhanced-hightlight
" ---------------------------------------------------------------------------
let g:cpp_experimental_template_highlight = 1
"let g:cpp_class_scope_highlight = 1

" ---------------------------------------------------------------------------
" vim-better-whitespace
" ---------------------------------------------------------------------------
let g:better_whitespace_filetypes_blacklist=['mail', 'tex', 'text']

" ---------------------------------------------------------------------------
" Python
" ---------------------------------------------------------------------------
let python_highlight_all = 1

" ---------------------------------------------------------------------------
" clighter
" ---------------------------------------------------------------------------
"let g:clighter_compile_args = [
"            \   "-I/usr/local/include/libsdlc-0.5.4",
"            \   "-I/usr/local/lib/libsdlc-0.5.4/include"
"            \   ]
let g:clighter_libclang_file = '/usr/lib/llvm-3.6/lib/libclang.so.1'
let g:clighter_highlight_blacklist = [
            \   'cligherInclusionDirective',
            \   ]

" Free functions
hi link clighterDeclRefExprCall Function
hi link clighterFunctionDecl Function

" Enums
hi link clighterEnumDecl Identifier
hi link clighterEnumConstantDecl Constant
hi link clighterDeclRefExprEnum Constant

hi link clighterMacroInstantiation Constant
hi link clighterPrepro PreProc

" Member variable and method calls
hi link clighterMemberRefExprCall Function

" Not working
hi link clighterMemberRefExprVar Error

" namespace { ... }
hi link clighterNamespace Constant
hi link clighterNamespaceRef Constant

hi link clighterOccurrences IncSearch

" Templated types
hi link clighterTemplateRef Type

" References to templated types
hi link clighterTypeRef Type

" The 'T' in template <class T>
hi link clighterTemplateTypeParameter Type

" class/struct declarations
hi link clighterClassDecl None
hi link clighterStructDecl None

" 'using name = ...' statements
hi link clighterDecl None

" Class member variable declarations
hi link clighterFieldDecl None

" Function parameters, including the template types
hi link clighterParmDecl None

" Lambda campture variables, using std::name statements
hi link clighterRef None

hi link clighterUnionDecl None

" Local variables
hi link clighterVarDecl None

" ---------------------------------------------------------------------------
" vim-hindent
" ---------------------------------------------------------------------------
let g:hindent_style = "gibiansky"

" ---------------------------------------------------------------------------
" GUI specific settings
" ---------------------------------------------------------------------------
if has("gui_running")
    if has("gui_gtk2")
        silent! colorscheme molokai
        silent! set guifont=Droid\ Sans\ Mono\ 11
        "silent! set guifont=Liberation\ Mono\ 13
        set guioptions-=m   " remove menubar
        set laststatus=2
        let g:airline#extensions#tabline#enabled = 1
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
