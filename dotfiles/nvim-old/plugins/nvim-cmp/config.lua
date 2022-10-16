local cmp = require "cmp"
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local lspkind = require('lspkind')

cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    })
  },

  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
  }),

  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
  },{
    { name = 'buffer' },
    { name = 'emoji' },
    { name = 'npm', keyword_length = 3 },
    { name = 'path' },
    { name = "ultisnips" },
  })
}

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(lsp_capabilities)
local lspconfig = require "lspconfig"

lspconfig.dockerls.setup {
  capabilities = cmp_capabilities,
}

lspconfig.html.setup {
  capabilities = cmp_capabilities,
}

lspconfig.jsonls.setup {
  capabilities = cmp_capabilities,
}

lspconfig.tsserver.setup {
  capabilities = cmp_capabilities,
}

lspconfig.yamlls.setup {
  capabilities = cmp_capabilities,
}
