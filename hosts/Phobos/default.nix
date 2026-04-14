{ pkgs, unstablePkgs, ... }:

{
  users.users.leemhenson = {
    name = "leemhenson";
    home = "/Users/leemhenson";
  };

  ids.gids.nixbld = 30000;
  nix.enable = false;
  documentation.enable = false;
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    defaults = {
      NSGlobalDomain = {
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      dock = {
        autohide = true;
      };

      finder = {
        FXPreferredViewStyle = "Nlsv";
      };

      trackpad = {
        Clicking = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    primaryUser = "leemhenson";
    stateVersion = 5;
  };

  homebrew = import ../../dotfiles/homebrew/homebrew.nix;

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    zsh = {
      enable = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.leemhenson = { pkgs, ... }: {
      fonts.fontconfig.enable = true;

      xdg = {
        enable = true;

        configFile."bat/config".source = ../../dotfiles/bat/config;
        configFile."helix/config.toml".source = ../../dotfiles/helix/config.toml;
        configFile."nix/nix.conf".source = ../../dotfiles/nix/nix.conf;
        configFile."nvim/init.lua".source = ../../dotfiles/nvim/init.lua;
        configFile."vscode/wrapper/code".source = ../../dotfiles/vscode/wrapper/code;
        configFile."vscode-insiders/wrapper/code-insiders".source = ../../dotfiles/vscode-insiders/wrapper/code;
        configFile."zed/keymap.json".source = ../../dotfiles/zed/keymap.json;
        configFile."zed/settings.json".source = ../../dotfiles/zed/settings.json;
      };

      home = {
        file = pkgs.lib.mapAttrs' (name: _: {
          name = ".claude/skills/${name}";
          value = { source = ../../dotfiles/claude/skills + "/${name}"; };
        }) (builtins.readDir ../../dotfiles/claude/skills);

        packages = with pkgs; [
          bash
          bat
          btop
          cargo
          cmake
          colima
          curl
          docker-compose
          exiftool
          fd
          ffmpeg
          gawk
          git-lfs
          httpie
          imagemagick
          jdk17
          jq
          libwebp
          lsd
          lua-language-server # needed for lua language server in nvim
          nil # needed for nix language server in neovim
          nixfmt-rfc-style                              # formatter for Nix
          nodejs-slim
          nodePackages."@tailwindcss/language-server"
          nodePackages.typescript-language-server
          openssh
          openssl
          pgcli
          readline
          ripgrep
          ruby
          serie
          sqlfluff                                      # formatter/linter for SQL
          stylua                                        # formatter for Lua
          tldr
          tree-sitter             # needed by nvim-treesitter to compile parsers
          unstablePkgs.helix
          vscode-langservers-extracted  # provides vscode-eslint-language-server
          watchman
          wget
          yarn
        ];

        stateVersion = "22.05";
      };

      programs = {
        direnv = import ../../dotfiles/direnv/direnv.nix;
        fzf = import ../../dotfiles/fzf/fzf.nix;
        git = import ../../dotfiles/git/git.nix pkgs;
        gpg.enable = true;
        htop.enable = true;
        man.enable = true;
        ssh = import ../../dotfiles/ssh/ssh.nix;
        wezterm = import ../../dotfiles/wezterm/wezterm.nix { pkgs = pkgs; };
        zsh = import ../../dotfiles/zsh/zsh.nix pkgs;
      };
    };
  };
}
