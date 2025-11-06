{ pkgs, ... }:

let
  unstablePkgs = import <nixpkgs-unstable> {}; # Importing the unstable channel
in
{
  users.users.leemhenson = {
    name = "leemhenson";
    home = "/Users/leemhenson";
  };

  ids.gids.nixbld = 30000;
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

    users.leemhenson = { pkgs, ... }: {
      fonts.fontconfig.enable = true;

      xdg = {
        enable = true;

        configFile."bat/config".source = ../../dotfiles/bat/config;
        configFile."helix/config.toml".source = ../../dotfiles/helix/config.toml;
        configFile."nix/nix.conf".source = ../../dotfiles/nix/nix.conf;
        configFile."vscode/wrapper/code".source = ../../dotfiles/vscode/wrapper/code;
        configFile."vscode-insiders/wrapper/code-insiders".source = ../../dotfiles/vscode-insiders/wrapper/code;
      };

      home = {
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
          unstablePkgs.helix
          httpie
          imagemagick
          jdk17
          jq
          libwebp
          lsd
          nodejs-slim
          openssh
          openssl
          pgcli
          readline
          ripgrep
          ruby
          serie
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
        ssh = import ../../dotfiles/ssh/ssh.nix;
        wezterm = import ../../dotfiles/wezterm/wezterm.nix { pkgs = pkgs; };
        zsh = import ../../dotfiles/zsh/zsh.nix pkgs;
      };
    };
  };
}
