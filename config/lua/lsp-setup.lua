-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  --nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation') -- Already used by tmux

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').add({
  mode = { "n", "v" },
  {'<leader>c',     desc = '[C]ode',     },
  {'<leader>d',     desc = '[D]ocument', },
  {'<leader>h',     desc = '[H]elpers',  },
  {'<leader>r',     desc = '[R]ename',   },
  {'<leader>s',     desc = '[S]earch',   },
  {'<leader>g',     desc = '[G]rep',     },
  {'<leader>w',     desc = '[W]orkspace',},
  {'<leader><Tab>', desc = '[T]ab',      },
})

-- Setup neovim lua configuration
require('neodev').setup()

-- Setup LSP for specific languages
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Require :LspRestart if other instances of nvim are already running
local lspconfig = require'lspconfig'
local servers = {
  'clangd',
  'gopls',
  'rust_analyzer',
  'terraformls',
  'tflint',
  'nixd',
  'lua_ls',
  'bashls',
  'pyright',
  'jsonls',
  'zls',
  'jsonnet_ls',
  'ts_ls',
  'gdscript',
  'gdshader_lsp'
}

for _, server in ipairs(servers) do

  if server == 'nixd' then
    lspconfig[server].setup {
      on_attach = on_attach,
      settings = {
        diagnostic = {
          suppress = {
            "sema-escaping-with"
          }
        }
      }
    }

    goto continue
  end

  lspconfig[server].setup {
    on_attach = on_attach,
  }

  ::continue::
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
