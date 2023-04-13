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

" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

"lua <<EOF
"vim.cmd([[
"set signcolumn=yes
"autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
"]])
"EOF

" Code navigation shortcuts
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

"nnoremap <silent> gR     <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gA    <cmd>lua vim.lsp.buf.range_code_action()<CR>

nnoremap <silent> <c-]> <cmd>Telescope lsp_definitions<cr>
nnoremap <silent> gD <cmd>Telescope lsp_implementations<cr>
nnoremap <silent> 1gD <cmd>Telescope lsp_type_definitions<cr>
nnoremap <silent> gr <cmd>Telescope lsp_references<cr>
nnoremap <silent> g0 <cmd> Telescope lsp_document_symbols<cr>
"nnoremap <silent> gW <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <silent> gW <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <silent> gd <cmd>Telescope lsp_definitions<cr>

"nnoremap <silent> ga <cmd>Telescope lsp_code_actions<cr>
"nnoremap <silent> gA <cmd>Telescope lsp_range_code_actions<cr>

" Set updatetime for CursorHold
" 3000ms of no cursor movement to trigger CursorHold
set updatetime=3000
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

au FileType rust map <C-K> <cmd>lua vim.lsp.buf.format { async = true }<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
autocmd FileType rust set signcolumn=yes

nnoremap <silent> <leader>ct :lua require('crates').toggle()<cr>
nnoremap <silent> <leader>cr :lua require('crates').reload()<cr>

nnoremap <silent> <leader>cv :lua require('crates').show_versions_popup()<cr>
nnoremap <silent> <leader>cf :lua require('crates').show_features_popup()<cr>

nnoremap <silent> <leader>cu :lua require('crates').update_crate()<cr>
vnoremap <silent> <leader>cu :lua require('crates').update_crates()<cr>
nnoremap <silent> <leader>ca :lua require('crates').update_all_crates()<cr>
nnoremap <silent> <leader>cU :lua require('crates').upgrade_crate()<cr>
vnoremap <silent> <leader>cU :lua require('crates').upgrade_crates()<cr>
nnoremap <silent> <leader>cA :lua require('crates').upgrade_all_crates()<cr>

nnoremap <silent> <leader>cH :lua require('crates').open_homepage()<cr>
nnoremap <silent> <leader>cR :lua require('crates').open_repository()<cr>
nnoremap <silent> <leader>cD :lua require('crates').open_documentation()<cr>
nnoremap <silent> <leader>cC :lua require('crates').open_crates_io()<cr>

" ---------------------------------------------------------------------------
" Nerdcommenter plugin
" ---------------------------------------------------------------------------
let g:NERDCreateDefaultMappings = 0
nmap <leader>c<space> <plug>NERDCommenterToggle
xmap <leader>c<space> <plug>NERDCommenterToggle

" ---------------------------------------------------------------------------
" Nerdtree plugin
" ---------------------------------------------------------------------------
map <F2> :NERDTreeToggle<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

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
" trouble
" ---------------------------------------------------------------------------

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" ---------------------------------------------------------------------------
" GUI specific settings
" ---------------------------------------------------------------------------
if &t_Co == 256
    " If we have 256 colors in the current terminal, set some nice theme
    "silent! colorscheme molokai
    silent! colorscheme dracula
    " Disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    "set t_ut=
    " Use 24-bit colors
    set termguicolors
end

set guifont=FiraCode\ Nerd\ Font:h11

" --------------------------------------------------------------------------
" Helper functions
" --------------------------------------------------------------------------
function! ToggleColor()
    if !exists("g:colors_name")
        set t_Co=256
        colorscheme molokai
    else
        set t_Co=8
        colorscheme default
        set background=dark
    endif
endfunction

:command! -nargs=1 -range=% Filter %y z|tabnew|0put=@z|%!grep -n '<args>'
