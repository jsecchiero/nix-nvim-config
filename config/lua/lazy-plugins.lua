require('lazy').setup({
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    dir = vim.g.lazy_root .. '/which-key.nvim',
    opts = {},
  },

  -- File browser
  {
    'echasnovski/mini.files',
    dir = vim.g.lazy_root .. '/mini.files',
    dependencies = {
      -- Avoid to shows empty squares
      -- needs nerdfonts
      {
        'echasnovski/mini.icons',
        dir = vim.g.lazy_root .. '/mini.icons',
        config = function()
          require('mini.icons').setup()
        end,
      },
    },
    config = function()
      local mf = require('mini.files')
      mf.setup()

      local set_cwd = function()
        local state = mf.get_explorer_state()
        if state == nil then return end

        local path = state.branch[state.depth_focus]
        state.anchor = path

        vim.fn.chdir(path)
        vim.notify('Current working directory set to ' .. vim.inspect(path))
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local b = args.data.buf_id
          vim.keymap.set('n', '*', set_cwd, { buffer = b, desc = 'Set cwd' })
        end,
      })

      vim.keymap.set('n', '<leader>.', ':lua MiniFiles.open()<CR>', { desc = 'Open File [E]ditor' })
    end,
  },

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
    'echasnovski/mini.surround',
    dir = vim.g.lazy_root .. '/mini.surround',
    config = function()
      require('mini.surround').setup()
    end,
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
      vim.keymap.set('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>',  { desc = 'Tmux: Move to Left Pane',  silent = true })
      vim.keymap.set('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>',  { desc = 'Tmux: Move to Lower Pane', silent = true })
      vim.keymap.set('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>',    { desc = 'Tmux: Move to Upper Pane', silent = true })
      vim.keymap.set('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { desc = 'Tmux: Move to Right Pane', silent = true })
    end,
  },

  {
    'RyanMillerC/better-vim-tmux-resizer',
    dir = vim.g.lazy_root .. '/better-vim-tmux-resizer',
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_resizer_resize_count = 1
      vim.g.tmux_resizer_vertical_resize_count = 1
      vim.keymap.set('n', '<C-w><lt>', '<Cmd>TmuxResizeLeft<CR>',  { desc = 'Tmux: Resize Pane Left',  silent = true })
      vim.keymap.set('n', '<C-w>-',    '<Cmd>TmuxResizeDown<CR>',  { desc = 'Tmux: Resize Pane Down',  silent = true })
      vim.keymap.set('n', '<C-w>+',    '<Cmd>TmuxResizeUp<CR>',    { desc = 'Tmux: Resize Pane Up',    silent = true })
      vim.keymap.set('n', '<C-w>>',    '<Cmd>TmuxResizeRight<CR>', { desc = 'Tmux: Resize Pane Right', silent = true })
    end,
  },

  {
    'github/copilot.vim',
    dir = vim.g.lazy_root .. '/copilot.vim',
    config = function()
      vim.g.copilot_enabled = false
      vim.g.copilot_filetypes = {
        markdown = true,
        yaml = true,
      }
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        noremap = false,
        silent = true,
        desc = 'Copilot: Accept Suggestion'
      })
    end,
  },

  {
    'Exafunction/codeium.vim',
    dir = vim.g.lazy_root .. '/codeium.vim',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_bin = vim.g.codeium_path
      vim.g.codeium_no_tab_map = 1
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set('i', '<C-J>', 'codeium#Accept()', {
        expr = true,
        noremap = false,
        silent = true,
        desc = 'Codeium: Accept Suggestion'
      })
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

      require("gruvbox").setup({
        inverse = false,
        overrides = {
          Search = { bg = "#fabd2f", fg = "#282828", bold = true }, -- Make search matches visible
          IncSearch = { bg = "#fe8019", fg = "#282828", bold = true }, -- Highlight incremental search
        },
      })

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
      sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'location'},
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
          vim.keymap.set("n", "<leader>d", ":DapToggleRepl<CR>", { desc = "[d]ebug REPL" })
      end,
  },

  {
    'NickvanDyke/opencode.nvim',
    dir = vim.g.lazy_root .. '/opencode.nvim',
    config = function()
      vim.opt.autoread = true

      vim.keymap.set("x", "<leader>o", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
    end,
  },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
