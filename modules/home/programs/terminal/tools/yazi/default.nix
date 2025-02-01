{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  completion = import ./keymap/completion.nix { };
  help = import ./keymap/help.nix { };
  input = import ./keymap/input.nix { };
  manager = import ./keymap/manager.nix { inherit config namespace; };
  select = import ./keymap/select.nix { };
  tasks = import ./keymap/tasks.nix { };
  inherit (inputs) yazi-plugins;

  cfg = config.${namespace}.programs.terminal.tools.yazi;
in
{
  imports = lib.snowfall.fs.get-non-default-nix-files ./configs/plugins;

  options.${namespace}.programs.terminal.tools.yazi = {
    enable = mkBoolOpt false "Whether or not to enable yazi.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      miller
      ouch
      config.programs.ripgrep.package
      xdragon
      zoxide
      glow
    ];

    # Dumb workaround for no color with latest glow
    # https://github.com/Reledia/glow.yazi/issues/7
    home.sessionVariables = {
      "CLICOLOR_FORCE" = 1;
    };

    programs.yazi = {
      enable = true;
      package = pkgs.yazi;

      # NOTE: wrapper alias is yy
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;

      initLua = ./configs/init.lua;

      keymap = lib.mkMerge [
        completion
        help
        input
        manager
        select
        tasks
      ];

      plugins = {
        "chmod" = "${yazi-plugins}/chmod.yazi";
        "diff" = "${yazi-plugins}/diff.yazi";
        "full-border" = "${yazi-plugins}/full-border.yazi";
        "glow" = ./configs/plugins/glow.yazi;
        "jump-to-char" = "${yazi-plugins}/jump-to-char.yazi";
        "max-preview" = "${yazi-plugins}/max-preview.yazi";
        "miller" = ./configs/plugins/miller.yazi;
        "ouch" = ./configs/plugins/ouch.yazi;
        "smart-enter" = "${yazi-plugins}/smart-enter.yazi";
        "smart-filter" = "${yazi-plugins}/smart-filter.yazi";
        "sudo" = ./configs/plugins/sudo.yazi;
      };

      settings = import ./yazi.nix { inherit config lib pkgs; };
    };
  };
}
