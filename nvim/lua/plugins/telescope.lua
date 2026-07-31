return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    version = false,
    lazy = false,
    keys = {
        { "<leader>.", "<cmd>Telescope find_files<cr>", desc = "Find files (root dir)" },
        { "<leader>fb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
        { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Switch colorscheme" },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Edit recent files" },
        { "<leader>ft", "<cmd>Telescope tags<cr>", desc = "Show project tags" },
    },
    config = function()
        -- require('telescope').load_extension('fzf')
    end,
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            mappings = {
                i = {
                    ["<C-n>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.cycle_history_next(...)
                    end,

                    ["<C-p>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.cycle_history_prev(...)
                    end,

                    ["<C-j>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_next(...)
                    end,

                    ["<C-k>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_previous(...)
                    end,

                    ["<C-c>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.close(...)
                    end,

                    ["<Down>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_next(...)
                    end,

                    ["<Up>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_previous(...)
                    end,

                    ["<CR>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.select_default(...)
                    end,

                    ["<C-x>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.select_horizontal(...)
                    end,

                    ["<C-v>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.select_vertical(...)
                    end,

                    ["<C-t>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.select_tab(...)
                    end,

                    ["<C-u>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.preview_scrolling_up(...)
                    end,

                    ["<C-d>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.preview_scrolling_down(...)
                    end,

                    ["<PageUp>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.results_scrolling_up(...)
                    end,

                    ["<PageDown>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.results_scrolling_down(...)
                    end,

                    ["<Tab>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.toggle_selection + actions.move_selection_worse(...)
                    end,

                    ["<S-Tab>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.toggle_selection + actions.move_selection_better(...)
                    end,

                    ["<C-q>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.send_to_qflist + actions.open_qflist(...)
                    end,

                    ["<M-q>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.send_selected_to_qflist + actions.open_qflist(...)
                    end,

                    ["<C-l>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.complete_tag(...)
                    end,

                    ["<C-_>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.which_key(...)-- keys from pressing <C-/>
                    end,

                },

                n = {
                    ["<esc>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.close(...)
                    end,

                    ["<CR>"] =  function(...)
                        local actions = require("telescope.actions")
                        return actions.select_default(...)
                    end,

                    ["<C-x>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.select_horizontal(...)
                    end,

                    ["<C-v>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.select_vertical(...)
                    end,

                    ["<C-t>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.select_tab(...)
                    end,

                    -- ["<Tab>"] = function(...)
                    --     local actions = require("telescope.actions")
                    --     return actions.toggle_selection + actions.move_selection_worse(...)
                    -- end,

                    -- ["<S-Tab>"] = function(...)
                    --     local actions = require("telescope.actions")
                    --     return actions.toggle_selection + actions.move_selection_better(...)
                    -- end,

                    ["<C-q>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.send_to_qflist + actions.open_qflist(...)
                    end,

                    ["<M-q>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.send_selected_to_qflist + actions.open_qflist(...)
                    end,

                    ["j"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_next(...)
                    end,

                    ["k"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_previous(...)
                    end,

                    ["H"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_to_top(...)
                    end,

                    ["M"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_to_middle(...)
                    end,

                    ["L"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_to_bottom(...)
                    end,

                    ["<Down>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_next(...)
                    end,

                    ["<Up>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_selection_previous(...)
                    end,

                    ["gg"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_to_top(...)
                    end,

                    ["G"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.move_to_bottom(...)
                    end,

                    ["<C-u>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.preview_scrolling_up(...)
                    end,

                    ["<C-d>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.preview_scrolling_down(...)
                    end,

                    ["<PageUp>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.results_scrolling_up(...)
                    end,

                    ["<PageDown>"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.results_scrolling_down(...)
                    end,

                    ["?"] = function(...)
                        local actions = require("telescope.actions")
                        return actions.which_key(...)
                    end,
                },
            },
        },
        pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    }
}
