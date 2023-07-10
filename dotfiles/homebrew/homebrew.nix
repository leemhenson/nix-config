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
    "neovim"
    "rbenv"
    "ruby-build"
    "typesense-server"
  ];

  casks = [
    "discord"
    "iterm2"
    "react-native-debugger"
    "visual-studio-code"
    "warp"
  ];

  taps = [
    "typesense/homebrew-tap"
    "wix/brew"
  ];
}
