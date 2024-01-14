-- if gdb_path is empty then use the default gdb
if vim.g.gdb_path == nil then
  vim.g.gdb_path = "gdb"
end

local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = vim.g.gdb_path,
  args = { "-i", "dap" }
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = function()
      return vim.fn.input('Path to sources: ', vim.fn.getcwd() .. '/', 'dir')
    end,
  },
}
