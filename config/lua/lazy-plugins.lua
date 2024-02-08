require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  {
    'tpope/vim-fugitive',
    dir = vim.g.lazy_root .. '/vim-fugitive',
  },
  {
    'tpope/vim-rhubarb',
    dir = vim.g.lazy_root .. '/vim-rhubarb',
  },

  -- Detect tabstop and shiftwidth automatically
  {
    'tpope/vim-sleuth',
    dir = vim.g.lazy_root .. '/vim-sleuth',
  },

  -- Sorrounds text with brackets, parens, quotes, etc
  {
    'tpope/vim-surround',
    dir = vim.g.lazy_root .. '/vim-surround',
  },

  -- Session management
  {
    'tpope/vim-obsession',
    dir = vim.g.lazy_root .. '/vim-obsession',
    priority = 2000,
  },
  {
    'dhruvasagar/vim-prosession',
    dir = vim.g.lazy_root .. '/vim-prosession',
    config = function()
      vim.g.prosession_per_branch = 1
    end,
  },

  -- Tmux integration
  {
    'christoomey/vim-tmux-navigator',
    dir = vim.g.lazy_root .. '/vim-tmux-navigator',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-h>', ':<C-U>TmuxNavigateLeft<cr>',  {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<C-j>', ':<C-U>TmuxNavigateDown<cr>',  {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<C-k>', ':<C-U>TmuxNavigateUp<cr>',    {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<C-l>', ':<C-U>TmuxNavigateRight<cr>', {noremap = true, silent = true})
    end,
  },

  {
    'RyanMillerC/better-vim-tmux-resizer',
    dir = vim.g.lazy_root .. '/better-vim-tmux-resizer',
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_resizer_resize_count = 1
      vim.g.tmux_resizer_vertical_resize_count = 1
      vim.api.nvim_set_keymap('n', '<C-w><lt>', ':TmuxResizeLeft<CR>',  {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<C-w>-',    ':TmuxResizeDown<CR>',  {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<C-w>+',    ':TmuxResizeUp<CR>',    {noremap = true, silent = true})
      vim.api.nvim_set_keymap('n', '<C-w>>',    ':TmuxResizeRight<CR>', {noremap = true, silent = true})
    end,
  },

  -- Copilot
  {
    'github/copilot.vim',
    dir = vim.g.lazy_root .. '/copilot.vim',
    config = function()
      vim.g.copilot_filetypes = {
        markdown = true,
        yaml = true,
      }
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("\\<CR>")', {expr = true, noremap = false, silent = true})
    end,
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dir = vim.g.lazy_root .. '/nvim-lspconfig',
    dependencies = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        'j-hui/fidget.nvim',
        dir = vim.g.lazy_root .. '/fidget.nvim',
        tag = 'legacy.nvim',
        opts = {}
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      {
        'folke/neodev.nvim',
        dir = vim.g.lazy_root .. '/neodev.nvim',
      },
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dir = vim.g.lazy_root .. '/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        dir = vim.g.lazy_root .. '/LuaSnip',
      },
      {
        'saadparwaiz1/cmp_luasnip',
        dir = vim.g.lazy_root .. '/cmp_luasnip',
      },

      -- Adds LSP completion capabilities
      {
        'hrsh7th/cmp-nvim-lsp',
        dir = vim.g.lazy_root .. '/cmp-nvim-lsp',
      },

      -- Adds a number of user-friendly snippets
      {
        'rafamadriz/friendly-snippets',
        dir = vim.g.lazy_root .. '/friendly-snippets',
      },
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    dir = vim.g.lazy_root .. '/which-key.nvim',
    opts = {},
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    dir = vim.g.lazy_root .. '/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    -- Gruvbox theme
    'ellisonleao/gruvbox.nvim',
    dir = vim.g.lazy_root .. '/gruvbox.nvim',
    priority = 1000,
    config = function ()
      -- NOTE: You should make sure your terminal supports this
      vim.o.termguicolors = true

      -- Set colorscheme
      vim.o.background = 'dark'
      vim.cmd [[colorscheme gruvbox]]
    end
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dir = vim.g.lazy_root .. '/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'gruvbox',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    dir = vim.g.lazy_root .. '/Comment.nvim',
    opts = {},
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    dir = vim.g.lazy_root .. '/telescope.nvim',
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        dir = vim.g.lazy_root .. '/plenary.nvim',
      },
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        dir = vim.g.lazy_root .. '/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    --dir = vim.g.lazy_root .. '/nvim-treesitter',
    dir = vim.g.treesitter_root,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      dir = vim.g.lazy_root .. '/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Debug adapter plug-in. Debug anything in Neovim
  {
      "mfussenegger/nvim-dap",
      dir = vim.g.lazy_root .. '/nvim-dap',
      config = function()
          vim.keymap.set("n", "<leader>d", ":DapToggleRepl<CR>")
      end,
  },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
