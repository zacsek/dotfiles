local actions = require("telescope.actions")

return {
  defaults = {
    mappings = {
      i = {
        -- ["<C-j>"] = actions.move_selection_next,
        -- ["<C-k>"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
      },
      n = {
        -- ["<C-j>"] = actions.move_selection_next,
        -- ["<C-k>"] = actions.move_selection_previous,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<CR>"] = actions.select_default,
      },
    },
  },
}
