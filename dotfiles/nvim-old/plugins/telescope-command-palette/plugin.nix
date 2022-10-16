pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "telescope-command-palette";
  src = pkgs.fetchFromGitHub {
      owner = "LinArcX";
      repo = "telescope-command-palette.nvim";
      rev = "1944d6312b29a0b41531ea3cf3912f03e4eb1705";
      sha256 = "o0BMEETqqBF7rhU9k2I9lwtLOnrW4A3lQGePgJhzuxI=";
  };
}
