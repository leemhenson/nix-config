{
  enable = true;

  onActivation = {
    autoUpdate = true;
    upgrade = true;
  };

  brews = [
    "applesimutils"
    "docker"
    "gh"
    "gnu-sed"
  ];

  casks = [
    "discord"
    "iterm2"
    "react-native-debugger"
    "visual-studio-code"
    "warp"
  ];

  taps = [
    "wix/brew"
  ];
}
