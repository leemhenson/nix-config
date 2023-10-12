{ pkgs, lib, ... }:

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
        configFile."lsd/config.yaml".source = ../../dotfiles/lsd/config.yaml;
        configFile."lvim/config.lua".source = ../../dotfiles/lvim/config.lua;
        configFile."nix/nix.conf".source = ../../dotfiles/nix/nix.conf;
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
          awscli2
          bash
          bat
          btop
          cargo
          cmake
          colima
          curl
          docker-compose
          fd
          ffmpeg
          gawk
          git-lfs
          helix
          httpie
          imagemagick
          jdk11
          jq
          lsd
          (pkgs.nerdfonts.override { fonts = [
            "FiraCode"
            "Hack"
            "IosevkaTerm"
            "Monoid"
            "Overpass"
          ]; })
          nodejs-slim
          openssh
          openssl
          pgcli
          readline
          redis
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
        neovim = import ../../dotfiles/neovim/neovim.nix {
          inherit pkgs lib;
        };
        ssh = import ../../dotfiles/ssh/ssh.nix;
        zsh = import ../../dotfiles/zsh/zsh.nix pkgs;
      };
    };
  };
}
