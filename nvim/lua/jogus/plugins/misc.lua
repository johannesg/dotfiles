return {
	{ 'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' } },
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{ 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
	{ 'nvim-treesitter/nvim-treesitter-context'},
	{ 'theprimeagen/harpoon' },
	{ 'mbbill/undotree' },
	{ 'tpope/vim-fugitive' },
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
}
