{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;

  cfg = config.${namespace}.programs.terminal.tools.oh-my-posh;
in
{
  options.${namespace}.programs.terminal.tools.oh-my-posh = {
    enable = lib.mkEnableOption "oh-my-posh";
  };

  config = mkIf cfg.enable {
    programs.oh-my-posh = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      package = pkgs.oh-my-posh;
      settings = builtins.fromJSON (
        builtins.unsafeDiscardStringContext (builtins.readFile ./config.json)
      );
    };
  };
}
