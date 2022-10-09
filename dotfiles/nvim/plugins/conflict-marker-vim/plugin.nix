pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "conflict-marker-vim";
  src = pkgs.fetchFromGitHub {
      owner = "rhysd";
      repo = "conflict-marker.vim";
      rev = "22b6133116795ea8fb6705ddca981aa8faecedda";
      sha256 = "oms9CtQ9ZAeFxoX1q0Nqm9uXF/aPt2ig57CQQHVgA2Y=";
  };
}
