return {
	{ 'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' } },
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{ 'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        dependencies = { "windwp/nvim-ts-autotag" } },
	{ 'nvim-treesitter/nvim-treesitter-context'},
	{ 'theprimeagen/harpoon' },
	{ 'mbbill/undotree' },
	{ 'tpope/vim-fugitive' },
    { 'numToStr/Comment.nvim' },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim', 
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        -- See `:help lualine.txt`
        opts = {
          options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = '|',
 --           section_separators = '',
            section_separators = { left = '', right = '' },
--            component_separators = { left = '', right = '' }
          },
        }
    },

    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    }
}
