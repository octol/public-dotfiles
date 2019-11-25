" ---------------------------------------------------------------------------
" System default settings
"  These are lifted from debian defaults (debian.vim). Set these explicityly
"  in case we are on a different plattform.
" ---------------------------------------------------------------------------
set nocompatible        " use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------
if !has("compatible")
    if has("nvim")
        if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
            silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
    else
        if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
    endif

    " Specify a directory for plugins
    " - For Neovim: ~/.local/share/nvim/plugged
    " - Avoid using standard Vim directory names like 'plugin'
    if has("nvim")
        call plug#begin('~/.local/share/nvim/plugged')
    else
        call plug#begin('~/.vim/plugged')
    endif

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
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'mtdl9/vim-log-highlighting'
    Plug 'mhinz/vim-grepper'
    "Plug 'airblade/vim-gitgutter'
    Plug 'jceb/vim-orgmode'
    Plug 'tpope/vim-speeddating'
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

    " C/C++
    Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
    Plug 'vim-scripts/a.vim', { 'for' : ['c', 'cpp'] }
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for' : ['c','cpp'] }

    " Rust
    Plug 'rust-lang/rust.vim'

    " Fish shell
    Plug 'Stautob/vim-fish'

    " LSP
    " -----------------
    if has("nvim")
        "Plug 'autozimu/LanguageClient-neovim', {
        "    \ 'branch': 'next',
        "    \ 'do': 'bash install.sh',
        "    \ }
        "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        "Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
    else
        Plug 'prabirshrestha/async.vim'
        Plug 'prabirshrestha/vim-lsp'
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
    endif

    " Themes
    " ------
    Plug 'tomasr/molokai'
    Plug 'octol/vombatidae.vim'
    Plug 'chriskempson/base16-vim'
    Plug 'nanotech/jellybeans.vim'

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
if !has("compatible")
    set autochdir
endif

set breakindent             " indent wrapped lines to preserve indendation
"set showbreak=--------      " additional indent when wrapping lines
set linebreak               " soft-wrap only at certain characters

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
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"

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
au FileType rust nnoremap <silent> <C-K> :RustFmt<CR>

if has("nvim")
"    " ---------------------------------------------------------------------------
"    " Deoplete
"    " ---------------------------------------------------------------------------
"    let g:deoplete#enable_at_startup = 1
"
"    " ---------------------------------------------------------------------------
"    " LSP
"    " ---------------------------------------------------------------------------
"    let g:LanguageClient_serverCommands = {
"        \ 'rust': ['rustup', 'run', 'stable', 'rls'],
"        \ }
"
"    " Automatically start language servers.
"    let g:LanguageClient_autoStart = 1
"    let g:LanguageClient_settingsPath = "/home/jon/.config/nvim/settings.json"
"
"    nnoremap <F6> :call LanguageClient_contextMenu()<CR>
"    au FileType rust nnoremap <silent> <F7> :call LanguageClient#textDocument_hover()<CR>
"    au FileType rust nnoremap <silent> <F8> :pclose<CR>
"    au FileType rust nnoremap <silent> <leader>jd :call LanguageClient#textDocument_definition()<CR>
"    "au FileType rust nnoremap <silent> <C-K> :call LanguageClient#textDocument_formatting()<CR>
"    au FileType rust nnoremap <silent> <C-K> :RustFmt<CR>
"
"    au BufRead,BufNewFile rust setlocal signcolumn=yes
"
"    let g:LanguageClient_useVirtualText = 0
"
"    "let g:rustfmt_autosave = 1

    "function! CocCurrentFunction()
    "    return get(b:, 'coc_current_function', '')
    "endfunction

    "autocmd FileType rust set cmdheight=2
    autocmd FileType rust set updatetime=300
    " don't give |ins-completion-menu| messages.
    autocmd FileType rust set shortmess+=c

    " always show signcolumns
    autocmd FileType rust set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction<Paste>

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
else
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
            \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
            \ 'whitelist': ['rust'],
            \ })

    endif

    au BufRead,BufNewFile rust setlocal signcolumn=yes

    let g:lsp_signs_enabled = 1           " enable signs
    "let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

    " Autocomplete
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

    " Force refresh completion
    imap <F8> <Plug>(asyncomplete_force_refresh)

    " Keybindings
    map <F6> :LspDocumentDiagnostics<CR>
    map <S-F6> :cclose<CR>
    map <F7> :LspHover<CR>
    map <S-F7> :pclose<CR>
    nnoremap <leader>jd :LspDefinition<CR>
endif

" ---------------------------------------------------------------------------
" Nerdtree plugin
" ---------------------------------------------------------------------------
map <F2> :NERDTreeToggle<CR>

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
nnoremap <c-p> :GitFiles<cr>

" ---------------------------------------------------------------------------
" airline
" ---------------------------------------------------------------------------
let g:airline_powerline_fonts = 1
"let g:airline#extensions#hunks#enabled = 0

" Remove git branch
"let g:airline_section_b = ''
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
    if has("nvim")
        if !exists("g:colors_name")
            set t_Co=256
            colorscheme molokai
        else
            set t_Co=8
            colorscheme default
            set background=dark
        endif
    else
        if &t_Co==8
            set t_Co=256
            colorscheme molokai
        else
            set t_Co=8
            colorscheme default
            set background=dark
        endif
    endif
endfunction
