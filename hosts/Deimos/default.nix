{ pkgs, ... }:

{
  users.users.leemhenson = {
    name = "leemhenson";
    home = "/Users/leemhenson";
  };

  services.nix-daemon.enable = true; # Make sure the nix daemon always runs
  security.pam.enableSudoTouchIdAuth = true;

  homebrew = import ../../dotfiles/homebrew/homebrew.nix;
  programs.gnupg.agent.enable = true;
  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.leemhenson = { pkgs, ... }: {
      fonts.fontconfig.enable = true;
      nixpkgs.config.allowUnfree = true;

      xdg = {
        enable = true;

        configFile."bat/config".source = ../../dotfiles/bat/config;
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
          cmake
          colima
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

        stateVersion = "22.05";
      };

      programs.direnv = import ../../dotfiles/direnv/direnv.nix;
      programs.fzf = import ../../dotfiles/fzf/fzf.nix;
      programs.git = import ../../dotfiles/git/git.nix;
      programs.htop.enable = true;
      programs.man.enable = true;
      programs.neovim = import ../../dotfiles/nvim/nvim.nix pkgs;
      programs.ssh = import ../../dotfiles/ssh/ssh.nix;
      programs.zsh = import ../../dotfiles/zsh/zsh.nix pkgs;
    };
  };
}
