return {
    "ibhagwan/fzf-lua",
    event = 'VimEnter',
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local f = require("fzf-lua")
        local a = require("fzf-lua").actions

        -- INFO: Configuration
        f.setup({
            -- Not changing many of theses, more to have a reference of the useful ones.
            actions = {
                files = {
                    ["enter"]  = a.file_edit_or_qf,
                    ["ctrl-s"] = a.file_split,
                    ["ctrl-v"] = a.file_vsplit,
                    ["ctrl-t"] = a.file_tabedit,
                    ["ctrl-Q"] = a.file_sel_to_qf, -- Send only selected items to qf
                    ["ctrl-q"] = "select-all+accept",
                },
            },
            keymap = {
                builtin = {
                    ["alt-h"] = "toggle-help",
                    ["alt-a"] = "toggle-all",
                    ["ctrl-f"] = "toggle-fullscreen",
                    ["ctrl-p"] = "toggle-preview",
                },
                fzf = {
                    -- use cltr-q to select all items and convert to quickfix list
                    ["ctrl-q"] = "select-all+accept",
                }
            },
            oldfiles = {
                -- include buffers visited in this session
                include_current_session = true
            },
        })

        -- INFO: vim.ui.select
        -- https://github.com/ibhagwan/fzf-lua/wiki#automatic-sizing-of-heightwidth-of-vimuiselect
        require("fzf-lua").register_ui_select(function(_, items)
            local min_h, max_h = 0.15, 0.70
            local h = (#items + 4) / vim.o.lines
            if h < min_h then
                h = min_h
            elseif h > max_h then
                h = max_h
            end
            return { winopts = { height = h, width = 0.60, row = 0.40 } }
        end)

        -- INFO: Keymaps
        local set = function(lhs, rhs, desc)
            vim.keymap.set("n", "<leader>" .. lhs, rhs, { desc = desc })
        end

        -- Files
        set("sf", f.files, "[S]earch [F]iles")
        set("sb", f.buffers, "[S]earch [B]uffers")
        set("s.", function()
            -- search within current dir
            f.oldfiles({ cwd_only = true })
        end, "[S]earch Recent Files [.]")

        set("sn", function()
            f.files({ cwd = vim.fn.stdpath("config") })
        end, "[S]earch [N]eovim Config")

        set("so", function()
            f.files({ cwd = 'D:/Documents/obsidian/General' })
        end, "[S]earch [O]bsidian Vault")

        -- Search (Grep)
        set("sp", f.live_grep, "[S]earch by [G]rep")
        set("sw", f.grep_cword, "[S]earch [W]ord")
        set("s/", f.lgrep_curbuf, "[S]earch [/] Buffer by Grep")

        -- Git
        set("sgs", f.git_status, "[S]earch [G]it [S]tatus")
        set("sgd", f.git_diff, "[S]earch [G]it [D]iff")
        set("sgh", f.git_hunks, "[S]earch [G]it [H]unks")
        set("sgc", f.git_commits, "[S]earch [G]it [C]ommits")

        -- LSP / Diagnostics
        set("sd", f.diagnostics_document, "[S]earch [D]iagnostics - Document ")
        set("sD", f.diagnostics_workspace, "[S]earch [D]iagnostics - Workspace")
        set("slr", f.lsp_references, "[S]earch [L]SP [R]eferences")
        set("sld", f.lsp_definitions, "[S]earch [L]SP [D]efinitions")

        -- Misc
        set("sh", f.help_tags, "[S]earch [H]elp")
        set("sk", f.keymaps, "[S]earch [K]eymaps")
        set("sz", f.builtin, "[S]earch f[z]f-lua")
        set("sr", f.resume, "[S]earch [R]esume")
        set("sc", f.colorschemes, "[S]earch [C]olourschemes")
    end
}
