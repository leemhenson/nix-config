{ pkgs, ... }:

{
  users.users.leemhenson = {
    name = "leemhenson";
    home = "/Users/leemhenson";
  };

  documentation.enable = false;
  services.nix-daemon.enable = true; # Make sure the nix daemon always runs
  security.pam.enableSudoTouchIdAuth = true;

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

    users.leemhenson = { pkgs, ... }: {
      fonts.fontconfig.enable = true;

      nixpkgs.config.allowBroken = true;
      nixpkgs.config.allowUnfree = true;

      xdg = {
        enable = true;

        configFile."bat/config".source = ../../dotfiles/bat/config;
        configFile."lvim/config.lua".source = ../../dotfiles/lvim/config.lua;
        configFile."vscode/wrapper/code".source = ../../dotfiles/vscode/wrapper/code;
        configFile."vscode-insiders/wrapper/code-insiders".source = ../../dotfiles/vscode-insiders/wrapper/code;
      };

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
          cargo
          cmake
          colima
          curl
          docker-compose
          fd
          ffmpeg
          gawk
          git-lfs
          httpie
          imagemagick
          jdk11
          jq
          (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
          nodejs-slim
          openssh
          openssl
          pgcli
          readline
          ripgrep
          ruby
          tldr
          yarn
          watchman
          wget
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
        # neovim = import ../../dotfiles/nvim/nvim.nix pkgs;
        ssh = import ../../dotfiles/ssh/ssh.nix;
        zsh = import ../../dotfiles/zsh/zsh.nix pkgs;
      };
    };
  };
}
