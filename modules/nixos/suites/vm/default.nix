{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) enabled;

  cfg = config.${namespace}.suites.vm;
in
{
  options.${namespace}.suites.vm = {
    enable = lib.mkEnableOption "common vm configuration";
  };

  config = mkIf cfg.enable {
    khanelinix = {
      services = {
        spice-vdagentd = lib.mkDefault enabled;
        spice-webdav = lib.mkDefault enabled;
      };
    };
  };
}
