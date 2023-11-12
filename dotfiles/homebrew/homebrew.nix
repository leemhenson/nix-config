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
    "pulumi"
  ];

  casks = [
    "discord"
    "iterm2"
    "react-native-debugger"
    "visual-studio-code"
  ];

  taps = [
    "pulumi/tap"
    "wix/brew"
  ];
}
