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
    "terraform"
  ];

  casks = [
    "discord"
    "iterm2"
    "react-native-debugger"
    "visual-studio-code"
    "warp"
  ];

  taps = [
    "hashicorp/tap"
    "pulumi/tap"
    "wix/brew"
  ];
}
