{ pkgs, ... }:

{
  users.users.leemhenson = {
    name = "leemhenson";
    home = "/Users/leemhenson";
  };

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  programs.gnupg.agent.enable = true;
  programs.zsh.enable = true;

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
        "discord"
        "iterm2"
        "visual-studio-code"
        "warp"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.leemhenson = { pkgs, ... }: {
    home.stateVersion = "22.05";

    xdg = {
      enable = true;

      configFile."bat/config".source = ../../dotfiles/bat/config;
      configFile."vscode/wrapper/code".source = ../../dotfiles/vscode/wrapper/vscode;
      configFile."vscode-insiders/wrapper/code-insiders".source = ../../dotfiles/vscode-insiders/wrapper/code;
    };

    fonts.fontconfig.enable = true;

    nixpkgs.config.allowUnfree = true;

    home = {
      file = {
        iterm = {
          source = ../../dotfiles/iterm2/profile.json;
          target = "Library/Application Support/iTerm2/DynamicProfiles/profile.json";
        };
      };
    };

    home.packages = with pkgs; [
      bash
      bat
      cmake
      coreutils
      curl
      fd
      gawk
      gitAndTools.diff-so-fancy
      httpie
      jq
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
      openssh
      openssl
      pgcli
      readline
      ripgrep
      tldr
      wget
    ];

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      defaultOptions = [ "-e" "--height 25%" "--reverse" ];
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    programs.git = {
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
          editor = "$HOME/.config/vscode-insiders/wrapper/code --wait";
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
            cmd = "$HOME/.config/vscode-insiders/wrapper/code --wait $MERGED";
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
    };

    programs.htop.enable = true;

    programs.kitty = {
      enable = true;
    };

    programs.man.enable = true;

    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true;

      plugins = with pkgs.vimPlugins; [
        plenary-nvim
        null-ls-nvim
        nvim-lspconfig
        nvim-treesitter
        nvim-cmp
        cmp-buffer

        {
          plugin = kanagawa-nvim;
          type = "lua";
          config = ''
            require('kanagawa').setup()
            vim.cmd("colorscheme kanagawa")
          '';
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = ''
            require('lualine').setup {
              options = {
                theme = 'kanagawa'
              }
            }
          '';
        }
        {
          plugin = nvim-web-devicons;
          type = "lua";
          config = ''
            require('nvim-web-devicons').setup {
              default = true
            }
          '';
        }
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = ''
            require('nvim-tree').setup {
              actions = {
                open_file = {
                  quit_on_open = true,
                  resize_window = false
                }
              }
            }
          '';
        }
        {
          plugin = nvim-colorizer-lua;
          type = "lua";
          config = ''
            require('colorizer').setup()
          '';
        }
        {
          plugin = nvim-comment;
          type = "lua";
          config = ''
            require("nvim_comment").setup()
          '';
        }
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = ''
            require('gitsigns').setup()
          '';
        }
        {
          plugin = trouble-nvim;
          type = "lua";
          config = ''
            require("trouble").setup()
          '';
        }

        vim-nix
        vim-surround
        nvim-autopairs

        telescope-nvim
      ];
    };

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          identityFile = "$HOME/.ssh/github";
        };
      };
    };

    programs.zsh = {
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

      initExtra = ''
        HISTFILE=$HOME/Documents/zsh/.histfile
        KEYTIMEOUT=1

        # Do not require a leading '.' in a filename to be matched explicitly
        setopt GLOBDOTS

        # When searching for history entries in the line editor, do not display
        # duplicates of a line previously found, even if the duplicates are not contiguous.
        setopt HIST_FIND_NO_DUPS

        # If a new command line being added to the history list duplicates an older one,
        # the older command is removed from the list (even if it is not the previous event).
        setopt HIST_IGNORE_ALL_DUPS

        # Remove superfluous blanks from each command line being added to the history list
        setopt HIST_REDUCE_BLANKS

        # When writing out the history file, older commands that duplicate newer ones are omitted.
        setopt HIST_SAVE_NO_DUPS

        # immediately appends new commands to the histfile
        setopt INC_APPEND_HISTORY

        # Shaddapayourface
        unsetopt BEEP

        # clashes with INC_APPEND_HISTORY
        unsetopt SHARE_HISTORY

        # This speeds up pasting w/ autosuggest
        # https://github.com/zsh-users/zsh-autosuggestions/issues/238

        pasteinit() {
          OLD_SELF_INSERT=''${''${(s.:.)widgets[self-insert]}[2,3]}
          zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
        }

        pastefinish() {
          zle -N self-insert $OLD_SELF_INSERT
        }

        zstyle :bracketed-paste-magic paste-init pasteinit
        zstyle :bracketed-paste-magic paste-finish pastefinish
      '';

      oh-my-zsh = {
        enable = true;

        extraConfig = ''
          # This stops zsh-vi-mode steamrolling over fzf keybindings
          ZVM_INIT_MODE=sourcing
        '';

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
            sha256 = "ffD0iHf9WVuE6QzZCkuDgIWj+BY/BRxtYNMi8osJohI=";
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
        PATH = "$HOME/.config/vscode/wrapper:$HOME/.config/vscode-insiders/wrapper:$PATH";
      };

      shellAliases = {
        awk = "gawk";
        gcnv = "git commit --no-verify -m ";
        gt = "git tree";
        j = "z";
        ls = "ls -alh --color=auto";
      };
    };
  };
}
