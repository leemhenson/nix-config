{
  aliases = {
    tree = "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date-order";
  };

  enable = true;

  extraConfig = {
    apply.whitespace = "nowarn";

    color = {
      branch = "auto";
      diff = "auto";
      interactive = "auto";
      status = "auto";
      ui = true;

      diff-highlight = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };
    };

    core = {
      editor = "$HOME/.config/vscode-insiders/wrapper/code-insiders --wait";
      excludesfile = "$HOME/.config/git/ignore";
    };

    diff.tool = "Kaleidoscope";

    difftool = {
      prompt = false;

      Kaleidoscope.cmd = "ksdiff --partial-changeset --relative-path \\\"$MERGED\\\" -- \\\"$LOCAL\\\" \\\"$REMOTE\\\";";
    };

    fetch.prune = true;
    help.autocorrect = 1;

    merge = {
      renameLimit = 1000000;
      tool = "vscode";
    };

    mergetool = {
      keepBackup = false;

      Kaleidoscope = {
        cmd = "ksdiff --merge --output \\\"$MERGED\\\" --base \\\"$BASE\\\" -- \\\"$LOCAL\\\" --snapshot \\\"$REMOTE\\\" --snapshot";
        trustExitCode = true;
      };

      vscode = {
        cmd = "$HOME/.config/vscode-insiders/wrapper/code-insiders --wait $MERGED";
      };
    };

    pager = {
      diff = "diff-so-fancy | less --tabs=2 -RFX";
      show = "diff-so-fancy | less --tabs=4 -RFX";
    };

    pull.rebase = true;
    push.default = "current";
  };

  ignores = [
    "*~"
    ''\#*\#''
    ''\.#*''
    ".DS_Store"
    "/.dir-locals.el"
    "/.envrc"
    "/.vscode"
    "/npm-debug.log*"
    "/tags"
    "/tags.lock"
    "/tags.temp"
    "/vendor"
    "/yarn-error.log"
  ];

  signing = {
    key = "B1EA4611F4564B0C487DF4B44CC045383A6DCF55";
    signByDefault = true;
  };

  userEmail = "lee.m.henson@gmail.com";
  userName = "Lee Henson";
}
