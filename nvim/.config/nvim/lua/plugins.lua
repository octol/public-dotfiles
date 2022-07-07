return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- General
    use 'vimoutliner/vimoutliner'
    use 'jamessan/vim-gnupg'
    use 'preservim/nerdcommenter'
    use 'preservim/nerdtree'
    use 'jlanzarotta/bufexplorer'

    use 'ntpeters/vim-better-whitespace'
    use 'mtdl9/vim-log-highlighting'
    use 'editorconfig/editorconfig-vim'

    use 'tpope/vim-fugitive'
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    use 'kyazdani42/nvim-web-devicons'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                sections = {
                    lualine_b = {'diff', 'diagnostics'},
                    lualine_c = {{'filename', path = 1}},
                },
                inactive_sections = {
                    lualine_c = {{'filename', path = 1}},
                }
            }
        end
    }

    -- C++
    use {'vim-scripts/a.vim', ft = {'c', 'cpp'}}
    use {'octol/vim-cpp-enhanced-highlight', ft = {'c','cpp'}}

    -- Rust
    use 'rust-lang/rust.vim'

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'

    -- Extra for rust
    use 'simrat39/rust-tools.nvim'

    -- Snippet
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- Basic lua
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'

    -- Debugging (needs plenary from above as well)
    use 'mfussenegger/nvim-dap'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- LSP diagnostics highlight groups for color schemes that don't yet
    -- support the Neovim 0.5 builtin lsp client.
    use 'folke/lsp-colors.nvim'

    use {
        'saecki/crates.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }

    -- Themes
    use 'tomasr/molokai'
    use 'octol/vombatidae.vim'
    --use 'chriskempson/base16-vim'
    use 'nanotech/jellybeans.vim'
    --use {'dracula/vim', as = 'dracula'}
    use 'Mofiqul/dracula.nvim'
    use 'arzg/vim-colors-xcode'
    use 'shaunsingh/nord.nvim'
end)


