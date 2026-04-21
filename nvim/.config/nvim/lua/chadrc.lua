-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",

	transparency = true,

	hl_override = {
		NormalFloat = { bg = "NONE" },
		FloatBorder = { bg = "NONE" },
		Pmenu = { bg = "NONE" },
		Terminal = { bg = "NONE" },
		EndOfBuffer = { bg = "NONE" },
		FoldColumn = { bg = "NONE" },
		Folded = { bg = "NONE" },
		SignColumn = { bg = "NONE" },
		NormalNC = { bg = "NONE" },
		WhichKeyFloat = { bg = "NONE" },
		TelescopeBorder = { bg = "NONE" },
		TelescopeNormal = { bg = "NONE" },
		TelescopePromptBorder = { bg = "NONE" },
		TelescopePromptTitle = { bg = "NONE" },
		NvimTreeNormal = { bg = "NONE" },
		NvimTreeVertSplit = { bg = "NONE" },
		NvimTreeEndOfBuffer = { bg = "NONE" },
	},
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
