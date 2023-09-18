local keymap = vim.keymap.set

local function goto_prev_error()
    vim.diagnostic.goto_prev { severity = "Error" }
end

local function goto_next_error()
    vim.diagnostic.goto_next { severity = "Error" }
end

keymap({ "n", "v" }, "[e", goto_prev_error)
keymap({ "n", "v" }, "]e", goto_next_error)
keymap({ "n", "v" }, "[d", vim.diagnostic.goto_prev)
keymap({ "n", "v" }, "]d", vim.diagnostic.goto_next)

keymap("n", "].", vim.diagnostic.open_float)

keymap("n", "<space>d", function()
    require("telescope.builtin").diagnostics { bufnr = 0 }
end)

keymap("n", "<C-w><C-w>", "<cmd>MaximizerToggle!<CR>")

keymap("n", "<space>c", function ()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "qf" then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end)

keymap("n", "<space>k", function ()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())) do
        if vim.wo[win].previewwindow then
            vim.cmd.pclose()
            return
        end
    end
end)

-- Copilot
keymap("i", "<c-e>", function()
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
        local endkey = vim.api.nvim_replace_termcodes('<END>', true, false, true)
        vim.api.nvim_feedkeys(endkey, "i", true)
    end
end)