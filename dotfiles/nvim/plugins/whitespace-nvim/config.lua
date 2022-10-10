require('whitespace-nvim').setup()

vim.cmd [[
  augroup trim_whitespace_on_save
  autocmd!
  autocmd BufWritePre * lua require('whitespace-nvim').trim()
  augroup END
]]
