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
    "pulumi"
  ];

  casks = [
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
    "pamburus/tap"
    "pulumi/tap"
    "wix/brew"
  ];
}
