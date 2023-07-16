{ pkgs, lib }:

let
  fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
in
{
  defaultEditor = true;
  enable = true;
  extraLuaConfig = lib.fileContents ./config.lua;
  withNodeJs = true;
  withPython3 = true;
  withRuby = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    lualine-nvim
    nightfox-nvim
    nvim-lspconfig
    nvim-tree-lua
    nvim-treesitter.withAllGrammars
    plenary-nvim
    telescope-fzf-native-nvim
    telescope-nvim
    which-key-nvim
    #   plenary-nvim
    #   gruvbox-material
    #   mini-nvim
    #   (fromGitHub "HEAD" "elihunter173/dirbuf.nvim")
  ];
}
