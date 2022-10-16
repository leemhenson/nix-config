pkgs:

let
  cmp-npm = pkgs.callPackage ./plugins/cmp-npm/plugin.nix pkgs;
  cmp-nvim-lsp-signature-help = pkgs.callPackage ./plugins/cmp-nvim-lsp-signature-help/plugin.nix pkgs;
  conflict-marker-vim = pkgs.callPackage ./plugins/conflict-marker-vim/plugin.nix pkgs;
  fixcursorhold-nvim = pkgs.callPackage ./plugins/fixcursorhold-nvim/plugin.nix pkgs;
  fidget-nvim = pkgs.callPackage ./plugins/fidget-nvim/plugin.nix pkgs;
  git-blame-nvim = pkgs.callPackage ./plugins/git-blame-nvim/plugin.nix pkgs;
  incline-nvim = pkgs.callPackage ./plugins/incline-nvim/plugin.nix pkgs;
  jabs-nvim = pkgs.callPackage ./plugins/jabs-nvim/plugin.nix pkgs;
  move-nvim = pkgs.callPackage ./plugins/move-nvim/plugin.nix pkgs;
  nvim-lightbulb = pkgs.callPackage ./plugins/nvim-lightbulb/plugin.nix pkgs;
  nvim-notify = pkgs.callPackage ./plugins/nvim-notify/plugin.nix pkgs;
  nvim-scrollbar = pkgs.callPackage ./plugins/nvim-scrollbar/plugin.nix pkgs;
  nvim-surround = pkgs.callPackage ./plugins/nvim-surround/plugin.nix pkgs;
  nvim-tree = pkgs.callPackage ./plugins/nvim-tree/plugin.nix pkgs;
  nvim-treesitter-textsubjects = pkgs.callPackage ./plugins/nvim-treesitter-textsubjects/plugin.nix pkgs;
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
    deadnix
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.jsonlint
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
  ];

  plugins = with pkgs.vimPlugins; [
    {
      plugin = cmp-buffer;
    }
    {
      plugin = cmp-emoji;
    }
    {
      plugin = cmp-npm;
    }
    {
      plugin = cmp-nvim-lsp;
    }
    {
      plugin = cmp-nvim-lsp-signature-help;
    }
    {
      plugin = cmp-nvim-ultisnips;
    }
    {
      plugin = cmp-path;
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
      plugin = gitsigns-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/gitsigns-nvim/config.lua;
    }
    {
      plugin = hop-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/hop-nvim/config.lua;
    }
    {
      plugin = incline-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/incline-nvim/config.lua;
    }
    {
      plugin = jabs-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/jabs-nvim/config.lua;
    }
    {
      plugin = kanagawa-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/kanagawa-nvim/config.lua;
    }
    {
      plugin = lspkind-nvim;
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
      plugin = null-ls-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/null-ls-nvim/config.lua;
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
      plugin = nvim-code-action-menu;
    }
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-colorizer-lua/config.lua;
    }
    {
      plugin = nvim-comment;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-comment/config.lua;
    }
    {
      plugin = nvim-dap;
    }
    {
      plugin = nvim-dap-ui;
    }
    {
      plugin = nvim-lightbulb;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-lightbulb/config.lua;
    }
    {
      plugin = nvim-lspconfig;
    }
    {
      plugin = nvim-neoclip-lua;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-neoclip-lua/config.lua;
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
      plugin = nvim-tree;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-tree/config.lua;
    }
    {
      plugin = nvim-treesitter;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-treesitter/config.lua;
    }
    {
      plugin = nvim-treesitter-textobjects;
    }
    {
      plugin = nvim-treesitter-textsubjects;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-treesitter-textsubjects/config.lua;
    }
    {
      plugin = nvim-ts-autotag; # can't build this locally, so have to pull it from nixpkgs
    }
    {
      plugin = nvim-ts-rainbow;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-ts-rainbow/config.lua;
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/nvim-web-devicons/config.lua;
    }
    {
      plugin = plenary-nvim;
    }
    {
      plugin = project-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/project-nvim/config.lua;
    }
    {
      plugin = registers-nvim;
    }
    {
      plugin = renamer-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/renamer-nvim/config.lua;
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
      plugin = todo-comments-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/todo-comments-nvim/config.lua;
    }
    {
      plugin = trouble-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/trouble-nvim/config.lua;
    }
    {
      plugin = ultisnips;
    }
    {
      plugin = vim-visual-multi;
    }
    {
      plugin = which-key-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/which-key-nvim/config.lua;
    }
    {
      plugin = whitespace-nvim;
      type = "lua";
      config = builtins.readFile ../../dotfiles/nvim/plugins/whitespace-nvim/config.lua;
    }
  ];

  /* extraConfig = builtins.readFile ../../dotfiles/nvim/extra-config.vim; */
  extraConfig = ''
    :luafile ~/.config/nvim/lua/init.lua
  '';
}
