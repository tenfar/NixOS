{ options
, config
, lib
, inputs
, pkgs
, osConfig
, ...
}:
with lib;
with lib.internal; let
  cfg = config.khanelinix.system.shell.fish;
  fishBasePath = inputs.dotfiles.outPath + "/dots/shared/home/.config/fish/";
in
{
  options.khanelinix.system.shell.fish = with types; {
    enable = mkBoolOpt false "Whether to enable fish.";
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "fish/themes".source = fishBasePath + "themes/";
      "fish/functions/bak.fish".source = fishBasePath + "functions/bak.fish";
      "fish/functions/cd.fish".source = fishBasePath + "functions/cd.fish";
      "fish/functions/ex.fish".source = fishBasePath + "functions/ex.fish";
      "fish/functions/git.fish".source = fishBasePath + "functions/git.fish";
      "fish/functions/load_ssh.fish".source = fishBasePath + "functions/load_ssh.fish";
      "fish/functions/mkcd.fish".source = fishBasePath + "functions/mkcd.fish";
      "fish/functions/mvcd.fish".source = fishBasePath + "functions/mvcd.fish";
      "fish/functions/ranger.fish".source = fishBasePath + "functions/ranger.fish";
      # "fish/completions/nix.fish".source = "${pkgs.nix}/share/fish/vendor_completions.d/nix.fish";
    };

    programs.fish = {
      enable = true;

      loginShellInit =
        let
          # This naive quoting is good enough in this case. There shouldn't be any
          # double quotes in the input string, and it needs to be double quoted in case
          # it contains a space (which is unlikely!)
          dquote = str: "\"" + str + "\"";

          makeBinPathList = map (path: path + "/bin");
        in
        lib.optionalString pkgs.stdenv.isDarwin ''
          export NIX_PATH="darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH"
          fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList osConfig.environment.profiles)}
          set fish_user_paths $fish_user_paths
        '';

      interactiveShellInit = lib.optionalString pkgs.stdenv.isDarwin ''
        # 1password plugin
        if [ -f ~/.config/op/plugins.sh ];
            source ~/.config/op/plugins.sh
        end

        # Brew environment
        if [ -f /opt/homebrew/bin/brew ];
        	eval "$("/opt/homebrew/bin/brew" shellenv)"
        end

        # Nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish' ];
         source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        end
        if [ -f '/nix/var/nix/profiles/default/etc/profile.d/nix.fish' ];
         source '/nix/var/nix/profiles/default/etc/profile.d/nix.fish'
        end
        # End Nix
      '' + lib.optionalString pkgs.stdenv.isLinux ''
        if [ $(command -v hyprctl) ];
            # Hyprland logs 
            alias hl='cat /tmp/hypr/$(lsd -t /tmp/hypr/ | head -n 1)/hyprland.log'
            alias hl1='cat /tmp/hypr/$(lsd -t -r /tmp/hypr/ | head -n 2 | tail -n 1)/hyprland.log'
        end
      '' + ''
        # Disable greeting
        set fish_greeting 

        # Fetch on terminal open
        if [ "$TMUX" = "" ];
            command -v tmux && tmux
        end

        fastfetch 
      '';

      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        # { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        {
          name = "autopair";
          inherit (pkgs.fishPlugins.autopair) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
        {
          name = "fzf-fish";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
        {
          name = "forgit";
          inherit (pkgs.fishPlugins.forgit) src;
        }
        {
          name = "tide";
          inherit (pkgs.fishPlugins.tide) src;
        }
        {
          name = "sponge";
          inherit (pkgs.fishPlugins.sponge) src;
        }
        {
          name = "wakatime";
          inherit (pkgs.fishPlugins.wakatime-fish) src;
        }
        {
          name = "z";
          inherit (pkgs.fishPlugins.z) src;
        }
      ];
    };
  };
}

