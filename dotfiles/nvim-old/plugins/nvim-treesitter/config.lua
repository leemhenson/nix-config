require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "graphql",
    "html",
    "http",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "make",
    "markdown",
    "nix",
    "python",
    "regex",
    "ruby",
    "rust",
    "scala",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },

  sync_install = false,

  autotag = {
    enable = true,
    filetypes = {
      "html",
      "jsx",
      "tsx",
      "xml",
    },
  },

  highlight = {
    enable = true,
  },

  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'none',
      peek_definition_code = {
        ["<leader>pf"] = "@function.outer",
        ["<leader>pc"] = "@class.outer"
      },
    },
  },
}
