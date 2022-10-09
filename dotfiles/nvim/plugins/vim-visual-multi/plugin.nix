pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "vim-visual-multi";
  src = pkgs.fetchFromGitHub {
      owner = "mg979";
      repo = "vim-visual-multi";
      rev = "724bd53adfbaf32e129b001658b45d4c5c29ca1a";
      sha256 = "Xq2guPaVNRZu8vnkEr1dYZrjou0QBbpXxgNqSBn0HTY=";
  };
}
