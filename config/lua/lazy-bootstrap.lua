-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info

if vim.g.lazy_root == nil then
  vim.g.lazy_root = vim.env.HOME .. '/.local/share/' .. vim.env.NVIM_APPNAME .. '/lazy'
end
local lazypath = vim.g.lazy_root .. '/lazy.nvim'

if vim.g.treesitter_root == nil then
  vim.g.treesitter_root = vim.env.HOME .. '/.local/share/' .. vim.env.NVIM_APPNAME .. '/lazy'
end

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp = vim.opt.rtp + lazypath

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
