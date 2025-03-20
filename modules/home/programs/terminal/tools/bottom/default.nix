{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;

  cfg = config.${namespace}.programs.terminal.tools.bottom;
in
{
  options.${namespace}.programs.terminal.tools.bottom = {
    enable = lib.mkEnableOption "bottom";
  };

  config = mkIf cfg.enable {
    programs.bottom = {
      enable = true;
      package = pkgs.bottom;

      settings = {
        flags.group_processes = true;

        row = [
          {
            ratio = 3;
            child = [
              { type = "cpu"; }
              { type = "mem"; }
              { type = "net"; }
            ];
          }
          {
            ratio = 3;
            child = [
              {
                type = "proc";
                ratio = 1;
                default = true;
              }
            ];
          }
        ];
      };
    };
  };
}
