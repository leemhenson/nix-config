pkgs:

let
  cmp-npm = pkgs.callPackage ./plugins/cmp-npm/plugin.nix pkgs;
  cmp-nvim-lsp-signature-help = pkgs.callPackage ./plugins/cmp-nvim-lsp-signature-help/plugin.nix pkgs;
  conflict-marker-vim = pkgs.callPackage ./plugins/conflict-marker-vim/plugin.nix pkgs;
  fixcursorhold-nvim = pkgs.callPackage ./plugins/fixcursorhold-nvim/plugin.nix pkgs;
  fidget-nvim = pkgs.callPackage ./plugins/fidget-nvim/plugin.nix pkgs;
  git-blame-nvim = pkgs.callPackage ./plugins/git-blame-nvim/plugin.nix pkgs;
  move-nvim = pkgs.callPackage ./plugins/move-nvim/plugin.nix pkgs;
  nvim-lightbulb = pkgs.callPackage ./plugins/nvim-lightbulb/plugin.nix pkgs;
  nvim-notify = pkgs.callPackage ./plugins/nvim-notify/plugin.nix pkgs;
  nvim-scrollbar = pkgs.callPackage ./plugins/nvim-scrollbar/plugin.nix pkgs;
  nvim-surround = pkgs.callPackage ./plugins/nvim-surround/plugin.nix pkgs;
  nvim-tree = pkgs.callPackage ./plugins/nvim-tree/plugin.nix pkgs;
  project-nvim = pkgs.callPackage ./plugins/project-nvim/plugin.nix pkgs;
  telescope-command-palette = pkgs.callPackage ./plugins/telescope-command-palette/plugin.nix pkgs;
  vim-visual-multi = pkgs.callPackage ./plugins/vim-visual-multi/plugin.nix pkgs;
  whitespace-nvim = pkgs.callPackage ./plugins/whitespace-nvim/plugin.nix pkgs;
in
{
  enable = true;

  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  withNodeJs = true;

  extraPackages = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
  ];

  plugins = with pkgs.vimPlugins; [
    plenary-nvim

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
      plugin = conflict-marker-vim;
      config = builtins.readFile ../../dotfiles/nvim/plugins/conflict-marker-vim/config.viml;
    }
    {
      plugin = fidget-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/fidget-nvim/config.lua;
    }
    {
      plugin = fixcursorhold-nvim; # this is for nvim-lightbulb, can be removed with neovim 0.8
    }
    {
      plugin = git-blame-nvim;
    }
    {
      plugin = hop-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/hop-nvim/config.lua;
    }
    {
      plugin = kanagawa-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/kanagawa-nvim/config.lua;
    }
    {
      plugin = lualine-nvim; # can't build this locally, so have to pull it from nixpkgs
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/lualine-nvim/config.lua;
    }
    {
      plugin = move-nvim;
    }
    {
      plugin = neogit; # can't build this locally, so have to pull it from nixpkgs
    }
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-autopairs/config.lua;
    }
    {
      plugin = nvim-cmp;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-cmp/config.lua;
    }
    {
      plugin = nvim-lightbulb;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-lightbulb/config.lua;
    }
    {
      plugin = nvim-notify;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-notify/config.lua;
    }
    {
      plugin = nvim-scrollbar;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-scrollbar/config.lua;
    }
    {
      plugin = nvim-surround;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-surround/config.lua;
    }
    {
      plugin = nvim-treesitter;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-treesitter/config.lua;
    }
    {
      plugin = nvim-ts-autotag; # can't build this locally, so have to pull it from nixpkgs
    }
    {
      plugin = project-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/project-nvim/config.lua;
    }
    {
      plugin = telescope-nvim; # can't build this locally, so have to pull it from nixpkgs
    }
    {
      plugin = telescope-command-palette;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/telescope-command-palette/config.lua;
    }
    {
      plugin = vim-visual-multi;
    }
    {
      plugin = whitespace-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/whitespace-nvim/config.lua;
    }
  ];

  extraConfig = builtins.readFile ../../dotfiles/nvim/extra-config.vim;
}
