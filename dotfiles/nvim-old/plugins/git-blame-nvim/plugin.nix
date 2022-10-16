pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "git-blame.nvim";
  src = pkgs.fetchFromGitHub {
      owner = "f-person";
      repo = "git-blame.nvim";
      rev = "08e75b7061f4a654ef62b0cac43a9015c87744a2";
      sha256 = "RQfQm8akoDC+tQgxl4LrDWKNPzuP43g7Q1X2gNdjbLY=";
  };
}
