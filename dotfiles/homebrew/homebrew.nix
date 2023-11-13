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
    "font-monaspace"
    "iterm2"
    "react-native-debugger"
    "visual-studio-code"
  ];

  taps = [
    "homebrew/cask-fonts"
    "pulumi/tap"
    "wix/brew"
  ];
}
