return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Basic lua components
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    -- Visualize lsp progress
    use {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
        require("fidget").setup()
        end
    }

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use({
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        after = { "hrsh7th/nvim-cmp" },
        requires = { "hrsh7th/nvim-cmp" },
    })

    -- Snippet
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    -- General
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use 'vimoutliner/vimoutliner'
    use 'jamessan/vim-gnupg'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'ntpeters/vim-better-whitespace'
    use 'editorconfig/editorconfig-vim'

    use 'mtdl9/vim-log-highlighting'
    use 'andreshazard/vim-logreview'
    use 'christoomey/vim-tmux-navigator'

    use 'tpope/vim-fugitive'
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup {
                sections = {
                    lualine_b = {'diff', 'diagnostics'},
                    lualine_c = {{'filename', path = 1}},
                },
                inactive_sections = {
                    lualine_c = {{'filename', path = 1}},
                },
                extensions = {'nvim-tree', 'trouble'},
                options = {
                    section_separators = '',
                    component_separators = '',
                },
            }
        end
    }

    use 'voldikss/vim-floaterm'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
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

    -- Copilot
    use 'github/copilot.vim'

    -- LSP diagnostics highlight groups for color schemes that don't yet
    -- support the Neovim 0.5 builtin lsp client.
    use 'folke/lsp-colors.nvim'

    -- Rust
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'
    use {
        'saecki/crates.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }

    -- Markdown
    use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}

    -- Themes
    use 'tomasr/molokai'
    use 'octol/vombatidae.vim'
    --use 'chriskempson/base16-vim'
    use 'nanotech/jellybeans.vim'
    --use {'dracula/vim', as = 'dracula'}
    use 'Mofiqul/dracula.nvim'
    use 'arzg/vim-colors-xcode'
    use 'shaunsingh/nord.nvim'
    -- use {
    --     'ray-x/starry.nvim', 
    --     setup = function() 
    --     vim.g.starry_italic_comments = true
    --     end
    -- }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "folke/tokyonight.nvim" }
end)


