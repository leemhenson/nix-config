pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "nvim-lightbulb";
  src = pkgs.fetchFromGitHub {
      owner = "kosayoda";
      repo = "nvim-lightbulb";
      rev = "56b9ce31ec9d09d560fe8787c0920f76bc208297";
      sha256 = "nw6H/dS4dHdrobnrfJVa8urWrMnbTWrA5bQJy9xbKXY=";
  };
}
