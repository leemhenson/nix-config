pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "project.nvim";
  src = pkgs.fetchFromGitHub {
      owner = "ahmedkhalf";
      repo = "project.nvim";
      rev = "628de7e433dd503e782831fe150bb750e56e55d6";
      sha256 = "Otm/XNVr978zlH69A7Qzr3Ej7qkHeZ8zi7nlQiAs8lw=";
  };
}
