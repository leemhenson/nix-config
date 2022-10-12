pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "incline-nvim";
  src = pkgs.fetchFromGitHub {
    owner = "b0o";
    repo = "incline.nvim";
    rev = "44d4e6f4dcf2f98cf7b62a14e3c10749fc5c6e35";
    sha256 = "oXmZK4cVyuSqmDUwJK0v7YL2g3Kr7zbMgk178D+zzys=";
  };
}
