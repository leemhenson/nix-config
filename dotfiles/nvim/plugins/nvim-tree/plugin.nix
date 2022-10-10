pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "nvim-tree";
  src = pkgs.fetchFromGitHub {
    owner = "kyazdani42";
    repo = "nvim-tree.lua";
    rev = "7282f7de8aedf861fe0162a559fc2b214383c51c";
    sha256 = "qcvhosFNyGwW+QQOj8HMySWVKaAMbfie0DY0mCmlCvU=";
  };
}
