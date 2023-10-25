{
  enable = true;

  onActivation = {
    autoUpdate = true;
    upgrade = true;
  };

  brews = [
    "applesimutils"
    "atlantis"
    "docker"
    "gh"
    "gnu-sed"
    "helm"
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
