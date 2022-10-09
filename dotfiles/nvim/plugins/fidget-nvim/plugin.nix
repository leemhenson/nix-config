pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "fidget.nvim";
  src = pkgs.fetchFromGitHub {
      owner = "j-hui";
      repo = "fidget.nvim";
      rev = "1097a86db8ba38e390850dc4035a03ed234a4673";
      sha256 = "5hWv6I6EaiKJzVpJm063KNksmfej/Wu4/zKLBqO7+pY=";
  };
}
