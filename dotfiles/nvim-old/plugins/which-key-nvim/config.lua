local wk = require("which-key")

wk.setup()
wk.register({
  ["<leader>"] = {
    b = {
      name = "+buffer",
      f = { "<cmd>Telescope buffers<cr>", "Find buffer" },
    },
    c = {
      name = "+command",
      f = { "<cmd>Telescope commands<cr>", "Find command" },
    },
    f = {
      name = "+file",
      f = { "<cmd>Telescope find_files<cr>", "Find file" },
      n = { "<cmd>enew<cr>", "New File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Recent file" },
    },
  },
})
