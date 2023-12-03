-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Copy all the line with Y
vim.api.nvim_set_keymap('n', 'Y', 'yy', {noremap = true})

-- Go back to the previous buffer (b#) with <leader><Tab>
vim.api.nvim_set_keymap('n', '<leader><Tab>', ':b#<CR>', {noremap = true})

-- Tmux
-- fix lazy vim remapping https://www.reddit.com/r/neovim/comments/14yer8w/neovimtmux_navigation_plugin_with_lazyvim_not/
vim.api.nvim_set_keymap('n', '<C-h>', ':<C-U>TmuxNavigateLeft<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':<C-U>TmuxNavigateDown<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':<C-U>TmuxNavigateUp<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':<C-U>TmuxNavigateRight<cr>', {noremap = true, silent = true})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
