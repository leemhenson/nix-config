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
    "jj"
    "pulumi"
  ];

  casks = [
    "discord"
    "font-fira-code"
    "font-monaspace"
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
