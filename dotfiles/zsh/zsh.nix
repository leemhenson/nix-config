pkgs: {
  enable = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;

  history = {
    expireDuplicatesFirst = true;
    extended = true;
    path = "$HOME/Documents/zsh/.histfile";
    save = 100000;
    size = 100000;
  };

  initExtra = builtins.readFile ./init-extra.zsh;

  oh-my-zsh = {
    enable = true;
    extraConfig = builtins.readFile ./oh-my-zsh-extra.zsh;
    plugins = [ "1password" "colored-man-pages" "git" "httpie" "ripgrep" "z" ];
    theme = "flazz";
  };

  plugins = [
    {
      file = "alias-tips.plugin.zsh";
      name = "alias-tips";
      src = pkgs.fetchFromGitHub {
        owner = "djui";
        repo = "alias-tips";
        rev = "cd13ef223c4f310d774cdf8cb0435474cc2bcbbe";
        sha256 = "fDYAJSJHatxHhAT68AH4PuIHdwxFXipAoDHITVpkkkE=";
      };
    }
    {
      file = "nix-shell.plugin.zsh";
      name = "zsh-nix-shell";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.5.0";
        sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      };
    }
    {
      file = "zsh-vi-mode.plugin.zsh";
      name = "zsh-vi-mode";
      src = pkgs.fetchFromGitHub {
        owner = "jeffreytse";
        repo = "zsh-vi-mode";
        rev = "v0.8.5";
        sha256 = "EOYqHh0rcgoi26eopm6FTl81ehak5kXMmzNcnJDH8/E=";
      };
    }
  ];

  sessionVariables = {
    BAT_PAGER = "";
    CLICOLOR = "true";
    NPM_CONFIG_USERCONFIG = "$HOME/Documents/dotfiles/npmrc";
    PATH = "./node_modules/.bin:$HOME/.config/vscode/wrapper:$HOME/.config/vscode-insiders/wrapper:$HOME/.local/bin:$HOME/.npm/global/bin:$PATH:/opt/homebrew/bin:$HOME/Library/Android/sdk/platform-tools";
  };

  shellAliases = {
    awk = "gawk";
    gcnv = "git commit --no-verify -m ";
    gt = "git tree";
    j = "z";
    ls = "lsd -al";
  };
}
