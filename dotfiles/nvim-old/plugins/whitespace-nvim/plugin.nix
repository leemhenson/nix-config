pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "whitespace.nvim";
  src = pkgs.fetchFromGitHub {
      owner = "johnfrankmorgan";
      repo = "whitespace.nvim";
      rev = "a0e7d918e14d295cad0090d88f5a13db177aa3e7";
      sha256 = "Gpskhsr9UGSbUtwe+ByJDxdAANIqKFrwqL41A7UJwJ4=";
  };
}
