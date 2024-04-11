{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    types
    mkEnableOption
    mkIf
    getExe'
    ;
  inherit (lib.internal) mkOpt mkBoolOpt enabled;
  inherit (config.khanelinix) user;

  cfg = config.khanelinix.tools.git;

  aliases = import ./aliases.nix;
in
{
  options.khanelinix.tools.git = {
    enable = mkEnableOption "Git";
    includes = mkOpt (types.listOf types.attrs) [ ] "Git includeIf paths and conditions.";
    signByDefault = mkOpt types.bool true "Whether to sign commits by default.";
    signingKey =
      mkOpt types.str "${config.home.homeDirectory}/.ssh/id_ed25519"
        "The key ID to sign commits with.";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
    wslAgentBridge = mkBoolOpt false "Whether to enable the wsl agent bridge.";
    _1password = mkBoolOpt false "Whether to enable 1Password integration.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bfg-repo-cleaner
      git-crypt
      git-filter-repo
      git-lfs
      gitflow
      gitleaks
      gitlint
    ];

    programs = {
      git = {
        enable = true;
        package = pkgs.gitFull;
        inherit (cfg) userName userEmail;
        inherit (aliases) aliases;
        lfs = enabled;

        delta = {
          enable = true;
        };

        extraConfig = {

          credential = {
            helper =
              if cfg.wslAgentBridge then
                ''/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe''
              else if pkgs.stdenv.isLinux then
                ''${getExe' config.programs.git.package "git-credential-libsecret"}''
              else
                ''${getExe' config.programs.git.package "git-credential-osxkeychain"}'';
            useHttpPath = true;
          };

          fetch = {
            prune = true;
          };

          gpg.format = "ssh";
          "gpg \"ssh\"".program = mkIf cfg._1password (
            ''''
            + ''${lib.optionalString pkgs.stdenv.isLinux (getExe' pkgs._1password-gui "op-ssh-sign")}''
            + ''${lib.optionalString pkgs.stdenv.isDarwin "${pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign"}''
          );

          init = {
            defaultBranch = "main";
          };

          pull = {
            rebase = true;
          };

          push = {
            autoSetupRemote = true;
          };

          rebase = {
            autoStash = true;
          };

          safe = {
            directory = [
              "~/khanelinix/"
              "/etc/nixos"
            ];
          };
        };

        inherit (cfg) includes;

        ignores = [
          ".DS_Store"
          "Desktop.ini"

          # Thumbnail cache files
          "._*"
          "Thumbs.db"

          # Files that might appear on external disks
          ".Spotlight-V100"
          ".Trashes"

          # Compiled Python files
          "*.pyc"

          # Compiled C++ files
          "*.out"

          # Application specific files
          "venv"
          "node_modules"
          ".sass-cache"

          ".idea*"
        ];

        signing = {
          key = cfg.signingKey;
          inherit (cfg) signByDefault;
        };
      };

      gh = {
        enable = true;

        settings = {
          version = "1";
        };

        gitCredentialHelper = {
          enable = true;
          hosts = [
            "https://github.com"
            "https://gist.github.com"
            "https://dibc@dev.azure.com"
            "https://core-bts-02@dev.azure.com"
          ];
        };
      };

      bash.initExtra = # bash
        ''
          export GITHUB_TOKEN="$(cat ${config.sops.secrets."github/access-token".path})"
        '';
      fish.shellInit = # fish
        ''
          export GITHUB_TOKEN="(cat ${config.sops.secrets."github/access-token".path})"
        '';
      zsh.initExtra = # bash
        ''
          export GITHUB_TOKEN="$(cat ${config.sops.secrets."github/access-token".path})"
        '';
    };

    home = {
      inherit (aliases) shellAliases;
    };

    sops.secrets = {
      "github/access-token" = {
        sopsFile = ../../../../secrets/khaneliman/default.yaml;
        path = "${config.home.homeDirectory}/.config/gh/access-token";
      };
    };
  };
}
