pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "jabs-nvim";
  src = pkgs.fetchFromGitHub {
    owner = "matbme";
    repo = "JABS.nvim";
    rev = "4ec901b1f30ae121f462380509800debdb273215";
    sha256 = "z8p36etgG73WMmFyT6VqY/vISRjwCzwSJJYZDHqD+MA=";
  };
}
