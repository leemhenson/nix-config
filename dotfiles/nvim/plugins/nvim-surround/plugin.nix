pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "nvim-surround";
  src = pkgs.fetchFromGitHub {
    owner = "kylechui";
    repo = "nvim-surround";
    rev = "17191679202978b1de8c1bd5d975400897b1b92d";
    sha256 = "LTlRdNJzrmh0UJWcxdkp9gg/I/sdIwPhb/8GO//BOzU=";
  };
}
