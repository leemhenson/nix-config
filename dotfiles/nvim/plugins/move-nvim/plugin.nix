pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "move-nvim";
  src = pkgs.fetchFromGitHub {
    owner = "fedepujol";
    repo = "move.nvim";
    rev = "2cd533590a133ae5fe751ca8081cd1a2047d7c7f";
    sha256 = "ePO+7tkrZUqA+DVOs3bVROSECmjKZchkPHPKFuP7Wo0=";
  };
}
