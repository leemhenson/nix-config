pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "cmp-nvim-lsp-signature-help";
  src = pkgs.fetchFromGitHub {
    owner = "hrsh7th";
    repo = "cmp-nvim-lsp-signature-help";
    rev = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb";
    sha256 = "/J/QRxiozsQFrwMcE/jTdbW3pQOR4xxtDCZ1X/gFyk0=";
  };
}
