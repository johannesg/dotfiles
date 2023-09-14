--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- package manager
require("jogus.lazy")

require("jogus.keymappings")
require("jogus.settings")
