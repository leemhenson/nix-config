pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "cmp-npm";
  src = pkgs.fetchFromGitHub {
    owner = "David-Kunz";
    repo = "cmp-npm";
    rev = "4b6166c3feeaf8dae162e33ee319dc5880e44a29";
    sha256 = "QggQ+axMaFcUCt2gfSpsDpM0YlxEkAiDCctzfYtceVI=";
  };
}
