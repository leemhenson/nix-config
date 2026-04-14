{
  enable = true;

  onActivation = {
    autoUpdate = true;
    upgrade = true;
  };

  brews = [
    "applesimutils"
    "delta"
    "docker"
    "gh"
    "gnu-sed"
    "hl"
    "mobile-dev-inc/tap/maestro"
    "neovim"
    "pulumi"
  ];

  casks = [
    "claude-code"
    "discord"
    "font-fira-code"
    "font-monaspace"
    "ghostty"
    "iterm2"
    "ngrok"
    "react-native-debugger"
    "visual-studio-code"
  ];

  taps = [
    "homebrew/cask-fonts"
    "mobile-dev-inc/tap"
    "pamburus/tap"
    "pulumi/tap"
    "wix/brew"
  ];
}
