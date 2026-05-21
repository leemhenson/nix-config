{
  enable = true;

  onActivation = {
    autoUpdate = true;
    upgrade = true;
  };

  brews = [
    "delta" # Syntax-highlighting pager for git and diff output
    "docker"
    "gh"
    "gnu-sed"
    "hl" # https://github.com/pamburus/hl
    "neovim"
    "pulumi"
  ];

  casks = [
    "claude-code"
    "discord"
    "font-fira-code"
    "font-monaspace"
    "ghostty"
    "google-cloud-sdk"
    "ngrok"
    "visual-studio-code"
  ];

  taps = [
    "homebrew/cask-fonts"
    "pamburus/tap" # hl
    "pulumi/tap"
  ];
}
