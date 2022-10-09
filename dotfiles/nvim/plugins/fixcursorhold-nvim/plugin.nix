pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "FixCursorHold.nvim";
  src = pkgs.fetchFromGitHub {
      owner = "antoinemadec";
      repo = "FixCursorHold.nvim";
      rev = "70a9516a64668cbfe59f31b66d0a21678c5e9b12";
      sha256 = "j6VtsMgaDWfdMGJyaPIw3Nk+9olfB5yHaEZgKepE5do=";
  };
}
