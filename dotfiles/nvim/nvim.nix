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
    lua53Packages.luacheck
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.jsonlint
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
  ];

  plugins = with pkgs.vimPlugins; [
    cmp-buffer
    cmp-emoji
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-path
    cmp_luasnip
    /* conflict-marker-vim */
    /* fidget-nvim */
    /* fixcursorhold-nvim # this is for nvim-lightbulb, can be removed with neovim 0.8 */
    /* git-blame-nvim */
    /* gitsigns-nvim */
    /* hop-nvim */
    /* incline-nvim */
    /* jabs-nvim */
    kanagawa-nvim
    lspkind-nvim
    lualine-nvim # can't build this locally, so have to pull it from nixpkgs
    luasnip
    /* move-nvim; */
    /* neogit # can't build this locally, so have to pull it from nixpkgs */
    null-ls-nvim
    /* nvim-autopairs */
    nvim-cmp
    /* nvim-code-action-menu */
    /* nvim-colorizer-lua */
    nvim-comment
    /* nvim-dap */
    /* nvim-dap-ui */
    /* nvim-lightbulb */
    nvim-lspconfig
    /* nvim-neoclip-lua */
    /* nvim-notify */
    /* nvim-scrollbar */
    /* nvim-surround */
    nvim-tree
    nvim-treesitter
    nvim-treesitter-textobjects
    nvim-treesitter-textsubjects
    /* nvim-ts-autotag # can't build this locally, so have to pull it from nixpkgs */
    /* nvim-ts-rainbow */
    /* nvim-web-devicons */
    plenary-nvim
    /* project-nvim */
    /* registers-nvim */
    /* renamer-nvim */
    /* telescope-nvim # can't build this locally, so have to pull it from nixpkgs */
    /* telescope-command-palette */
    /* todo-comments-nvim */
    /* trouble-nvim */
    /* vim-visual-multi */
    /* which-key-nvim */
    /* whitespace-nvim */
  ];

  extraConfig = ''
    :luafile ~/.config/nvim/lua/init.lua
  '';
}
