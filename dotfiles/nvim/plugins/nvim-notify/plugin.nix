pkgs:

pkgs.vimUtils.buildVimPlugin {
  name = "nvim-notify";
  src = pkgs.fetchFromGitHub {
      owner = "rcarriga";
      repo = "nvim-notify";
      rev = "e7cb3e5f93b1fef6a713dbc182eff98badfc6dd4";
      sha256 = "z5ZGn7bGKf3h/jwcizRxDIqJceghsYwbKcMj0RNF+p0=";
  };
}
