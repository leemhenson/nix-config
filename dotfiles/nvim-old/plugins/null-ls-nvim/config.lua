local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.deadnix,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "postgres" },
    }),
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.tidy,
    null_ls.builtins.diagnostics.tsc,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.alejandra,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.nginx_beautifier,
    null_ls.builtins.formatting.nixfmt,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustywind,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.sqlfluff.with({
        extra_args = { "--dialect", "postgres" },
    }),
    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.tidy,
  },
})
