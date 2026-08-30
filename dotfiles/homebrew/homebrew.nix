{
  enable = true;

  onActivation = {
    autoUpdate = true;
    upgrade = true;
  };

  brews = [
    "delta" # Syntax-highlighting pager for git and diff output
    "docker"
    "erlang"
    "gh"
    "gleam"
    "gnu-sed"
    "hl" # https://github.com/pamburus/hl
    "neovim"
    "ollama"
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
    "pamburus/tap" # hl
  ];
}
