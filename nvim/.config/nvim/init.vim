inoremap <F5> <C-R>=strftime("%a, %d %b %Y %H:%M:%S %z")<CR>

" ---------------------------------------------------------------------------
" Language specific
"  Note, cino=g0 indents the public/private keywords in C++ classes.
"  sw=shiftwidth, et=expandtab, sts=softtabstop, ts=tabstop
" ---------------------------------------------------------------------------

au FileType c set sw=4 sts=4 et cino=g0 tw=80
au FileType cpp set sw=4 sts=4 et cino=g0 tw=90
au FileType c,cpp,rust set showbreak=--------
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
au FileType cmake set sw=2 sts=2 et

" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Set updatetime for CursorHold
" 3000ms of no cursor movement to trigger CursorHold
set updatetime=3000
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

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
" telescope
" ---------------------------------------------------------------------------

nnoremap <c-p> <cmd>Telescope git_files<cr>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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

