pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "nvim-treesitter-textsubjects";
  src = pkgs.fetchFromGitHub {
    owner = "RRethy";
    repo = "nvim-treesitter-textsubjects";
    rev = "ce47997e9f661f2c78c510467bd9c8648f7c7481";
    sha256 = "dBqxVlWTVUE90p6dDW3rQUt6+BzDl4xlrtabiWhJYFs=";
  };
}
