{ pkgs, ... }:

let
  cmp-npm = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-npm";
    src = pkgs.fetchFromGitHub {
      owner = "David-Kunz";
      repo = "cmp-npm";
      rev = "4b6166c3feeaf8dae162e33ee319dc5880e44a29";
      sha256 = "QggQ+axMaFcUCt2gfSpsDpM0YlxEkAiDCctzfYtceVI=";
    };
  };
  cmp-nvim-lsp-signature-help = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-nvim-lsp-signature-help";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp-signature-help";
      rev = "3dd40097196bdffe5f868d5dddcc0aa146ae41eb";
      sha256 = "/J/QRxiozsQFrwMcE/jTdbW3pQOR4xxtDCZ1X/gFyk0=";
    };
  };
  nvim-scrollbar = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-scrollbar";
    src = pkgs.fetchFromGitHub {
      owner = "petertriho";
      repo = "nvim-scrollbar";
      rev = "ce0df6954a69d61315452f23f427566dc1e937ae";
      sha256 = "EqHoR/vdifrN3uhrA0AoJVXKf5jKxznJEgKh8bXm2PQ=";
    };
  };
  nvim-surround = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-surround";
    src = pkgs.fetchFromGitHub {
      owner = "kylechui";
      repo = "nvim-surround";
      rev = "17191679202978b1de8c1bd5d975400897b1b92d";
      sha256 = "LTlRdNJzrmh0UJWcxdkp9gg/I/sdIwPhb/8GO//BOzU=";
    };
  };
  lualine-lsp-progress = pkgs.vimUtils.buildVimPlugin {
    name = "lualine-lsp-progress";
    src = pkgs.fetchFromGitHub {
      owner = "WhoIsSethDaniel";
      repo = "lualine-lsp-progress.nvim";
      rev = "16380c531efad8131ba0f395bdeb97fa2ae169f4";
      sha256 = "pn40lMYSe5W1rFeF4TIlH+I64U7zK2m4VeyQQBRf+nw=";
    };
  };
in
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

      packages = with pkgs; [
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
        nodejs
        openssh
        openssl
        pgcli
        readline
        ripgrep
        tldr
        wget
      ];
    };

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

      extraPackages = with pkgs.nodePackages; [
        typescript
        typescript-language-server
      ];

      plugins = with pkgs.vimPlugins; [
        plenary-nvim
        nvim-treesitter

        null-ls-nvim
        nvim-lspconfig
        lspkind-nvim

        cmp-buffer
        cmp-emoji
        cmp-npm
        cmp-nvim-lsp
        cmp-nvim-lsp-signature-help
        cmp-nvim-ultisnips
        cmp-path
        {
          plugin = nvim-cmp;
          type = "lua";
          config = ''
            local cmp = require "cmp"
            local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
            local lspkind = require('lspkind')

            cmp.setup {
              formatting = {
                format = lspkind.cmp_format({
                  mode = 'symbol', -- show only symbol annotations
                  maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                  ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                })
              },

              mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
                ['<Esc>'] = cmp.mapping.abort(),
                ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
              }),

              snippet = {
                expand = function(args)
                  vim.fn["UltiSnips#Anon"](args.body)
                end,
              },

              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
              },{
                { name = 'buffer' },
                { name = 'emoji' },
                { name = 'npm', keyword_length = 3 },
                { name = 'path' },
                { name = "ultisnips" },
              })
            }

            local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(lsp_capabilities)

            require('lspconfig').tsserver.setup {
              capabilities = cmp_capabilities
            }
          '';
        }

        {
          plugin = kanagawa-nvim;
          type = "lua";
          config = ''
            require('kanagawa').setup()
            vim.cmd("colorscheme kanagawa")
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
        {
          plugin = which-key-nvim;
          type = "lua";
          config = ''
            local wk = require("which-key")
            wk.setup()
            wk.register({
              ["<leader>"] = {
                b = {
                  name = "+buffer",
                  f = { "<cmd>Telescope buffers<cr>", "Find buffer" },
                },
                c = {
                  name = "+command",
                  f = { "<cmd>Telescope commands<cr>", "Find command" },
                },
                f = {
                  name = "+file",
                  f = { "<cmd>Telescope find_files<cr>", "Find file" },
                  n = { "<cmd>enew<cr>", "New File" },
                  r = { "<cmd>Telescope oldfiles<cr>", "Recent file" },
                },
              },
            })
          '';
        }
        {
          plugin = nvim-scrollbar;
          type = "lua";
          config = ''
            require("scrollbar").setup()
          '';
        }

        vim-nix
        {
          plugin = nvim-surround;
          type = "lua";
          config = ''
            require("nvim-surround").setup()
          '';
        }
        {
          plugin = hop-nvim;
          type = "lua";
          config = ''
            require('hop').setup()

            vim.api.nvim_set_keymap('n', '<leader>s', ':HopChar1<CR>', { noremap = true, silent = true })
          '';
        }

        {
          plugin = nvim-autopairs;
          type = "lua";
          config = ''
            require("nvim-autopairs").setup()
          '';
        }

        telescope-nvim

        lualine-lsp-progress
        {
          plugin = lualine-nvim;
          type = "lua";
          config = ''
            require('lualine').setup {
              options = {
                theme = 'kanagawa'
              },
              sections = {
                lualine_c = {
                  'lsp_progress'
                }
              }
            }
          '';
        }

        # This is for nvim-lightbulb, can be removed with neovim 0.8
        FixCursorHold-nvim
        {
          plugin = nvim-lightbulb;
          type = "lua";
          config = ''
            require('nvim-lightbulb').setup({ autocmd = { enabled = true }})
          '';
        }
      ];

      extraConfig = ''
        let g:mapleader="\<SPACE>"

        set backupdir=~/.nvim/backup                      " Directory for backups
        set directory=~/.nvim/swap                        " Directory for swapfiles
        set undodir=~/.nvim/undo                          " Directory for undos

        set clipboard=unnamedplus                         " Allow copy/paste from anywhere
        set colorcolumn=100                               " Highlight 100th column
        set completeopt=menu,menuone,noselect,noinsert    " Insert mode completion
        set cursorline                                    " Highlight current line
        set hidden                                        " Enable hidden buffers (navigate away from buffer with unsaved changes)
        set mouse=a                                       " Enable the mouse in all modes
        set noshowmode                                    " Disable current-mode message
        set noswapfile                                    " Disable swap files for buffers
        set nowrap                                        " Disable line wrapping
        set nowritebackup                                 " Don't use file backups
        set number                                        " Show line numbers
        set scrolloff=30                                  " Number of lines to show around cursor
        set shada=" "                                     " Disable shada
        set shadafile=NONE                                " Disable shada
        set shiftwidth=2                                  " Number of spaces to use for each step of (auto)indent
        set shortmess=c                                   " Don't show completion messages
        set signcolumn=yes                                " Always render a sign column
        set smartindent                                   " Use smart autoindenting when starting a new line
        set splitbelow                                    " Open new splits below
        set splitright                                    " Open new splits to the right
        set tabstop=2                                     " Number of spaces that a <Tab> in the file counts for
        set termguicolors                                 " Enable 24-bit colors in terminal vim
        set timeoutlen=750                                " Time to wait for key combo

        nnoremap <ESC> :nohlsearch<CR>                    " Clear search results
      '';
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
