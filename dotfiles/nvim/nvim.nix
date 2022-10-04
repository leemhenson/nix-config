pkgs:

let
  cmp-npm = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-npm";
    src = pkgs.fetchFromGitHub {
      owner = "David-Kunz";
      repo = "cmp-npm";
      rev = "4b6166c3feeaf8dae162e33ee319dc5880e44a29";
      sha256 = "QggQ+axMaFcUCt2gfSpsDpM0YlxEkAiDCctzfYtceVI=";
    };
  };
  cmp-nvim-lsp-signature-help = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-nvim-lsp-signature-help";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp-signature-help";
      rev = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb";
      sha256 = "/J/QRxiozsQFrwMcE/jTdbW3pQOR4xxtDCZ1X/gFyk0=";
    };
  };
  lualine-lsp-progress = pkgs.vimUtils.buildVimPlugin {
    name = "lualine-lsp-progress";
    src = pkgs.fetchFromGitHub {
      owner = "WhoIsSethDaniel";
      repo = "lualine-lsp-progress.nvim";
      rev = "16380c531efad8131ba0f395bdeb97fa2ae169f4";
      sha256 = "pn40lMYSe5W1rFeF4TIlH+I64U7zK2m4VeyQQBRf+nw=";
    };
  };
  move-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "move-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "fedepujol";
      repo = "move.nvim";
      rev = "2cd533590a133ae5fe751ca8081cd1a2047d7c7f";
      sha256 = "ePO+7tkrZUqA+DVOs3bVROSECmjKZchkPHPKFuP7Wo0=";
    };
  };
  nvim-scrollbar = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-scrollbar";
    src = pkgs.fetchFromGitHub {
      owner = "petertriho";
      repo = "nvim-scrollbar";
      rev = "ce0df6954a69d61315452f23f427566dc1e937ae";
      sha256 = "EqHoR/vdifrN3uhrA0AoJVXKf5jKxznJEgKh8bXm2PQ=";
    };
  };
  nvim-surround = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-surround";
    src = pkgs.fetchFromGitHub {
      owner = "kylechui";
      repo = "nvim-surround";
      rev = "17191679202978b1de8c1bd5d975400897b1b92d";
      sha256 = "LTlRdNJzrmh0UJWcxdkp9gg/I/sdIwPhb/8GO//BOzU=";
    };
  };
  nvim-tree = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-tree";
    src = pkgs.fetchFromGitHub {
      owner = "kyazdani42";
      repo = "nvim-tree.lua";
      rev = "7282f7de8aedf861fe0162a559fc2b214383c51c";
      sha256 = "qcvhosFNyGwW+QQOj8HMySWVKaAMbfie0DY0mCmlCvU=";
    };
  };
  whitespace-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "whitespace-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "johnfrankmorgan";
      repo = "whitespace.nvim";
      rev = "a0e7d918e14d295cad0090d88f5a13db177aa3e7";
      sha256 = "Gpskhsr9UGSbUtwe+ByJDxdAANIqKFrwqL41A7UJwJ4=";
    };
  };
in
{
  enable = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  withNodeJs = true;

  extraPackages = with pkgs.nodePackages; [
    dockerfile-language-server-nodejs
    typescript
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
  ];

  plugins = with pkgs.vimPlugins; [
    plenary-nvim

    {
      plugin = nvim-treesitter;
      type = "lua";
      config = ''
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
          -- Install parsers synchronously (only applied to `ensure_installed`)
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
        }
      '';
    }

    null-ls-nvim
    nvim-lspconfig
    lspkind-nvim

    ultisnips
    cmp-buffer
    cmp-emoji
    cmp-npm
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-nvim-ultisnips
    cmp-path
    {
      plugin = nvim-cmp;
      type = "lua";
      config = ''
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
      '';
    }

    {
      plugin = kanagawa-nvim;
      type = "lua";
      config = ''
        require('kanagawa').setup()
        vim.cmd("colorscheme kanagawa")
      '';
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = ''
        require('nvim-web-devicons').setup {
          default = true
        }
      '';
    }
    {
      plugin = nvim-tree;
      type = "lua";
      config = ''
        require('nvim-tree').setup {
          actions = {
            open_file = {
              quit_on_open = true,
              resize_window = false
            }
          },
          respect_buf_cwd = true,
          sync_root_with_cwd = true,
          update_focused_file = {
            enable = true,
            update_root = true
          },
          view = {
            adaptive_size = true,
          }
        }
      '';
    }
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config = ''
        require('colorizer').setup()
      '';
    }
    {
      plugin = nvim-comment;
      type = "lua";
      config = ''
        require("nvim_comment").setup()
      '';
    }
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = ''
        require('gitsigns').setup()
      '';
    }
    {
      plugin = trouble-nvim;
      type = "lua";
      config = ''
        require("trouble").setup()
      '';
    }
    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
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
      '';
    }
    {
      plugin = nvim-scrollbar;
      type = "lua";
      config = ''
        require("scrollbar").setup()
      '';
    }

    move-nvim
    {
      plugin = nvim-surround;
      type = "lua";
      config = ''
        require("nvim-surround").setup()
      '';
    }
    {
      plugin = hop-nvim;
      type = "lua";
      config = ''
        require('hop').setup()

        vim.api.nvim_set_keymap('n', '<leader>s', ':HopChar1<CR>', { noremap = true, silent = true })
      '';
    }

    {
      plugin = nvim-autopairs;
      type = "lua";
      config = ''
        require("nvim-autopairs").setup()
      '';
    }
    nvim-ts-autotag
    {
      plugin = whitespace-nvim;
      type = "lua";
      config = ''
        require('whitespace-nvim').setup()

        vim.cmd [[
          augroup trim_whitespace_on_save
            autocmd!
            autocmd BufWritePre * lua require('whitespace-nvim').trim()
          augroup END
        ]]
      '';
    }

    telescope-nvim

    lualine-lsp-progress
    {
      plugin = lualine-nvim;
      type = "lua";
      config = ''
        require('lualine').setup {
          options = {
            theme = 'kanagawa'
          },
          sections = {
            lualine_c = {
              'lsp_progress'
            }
          }
        }
      '';
    }

    # This is for nvim-lightbulb, can be removed with neovim 0.8
    FixCursorHold-nvim
    {
      plugin = nvim-lightbulb;
      type = "lua";
      config = ''
        require('nvim-lightbulb').setup({ autocmd = { enabled = true }})
      '';
    }

    {
      plugin = project-nvim;
      type = "lua";
      config = ''
        require("project_nvim").setup()
        require('telescope').load_extension('projects')
      '';
    }

    neogit
    git-blame-nvim
    nvim-notify
  ];

  extraConfig = builtins.readFile ../../dotfiles/nvim/extra-config.vim;
}
