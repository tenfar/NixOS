{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;

  cfg = config.${namespace}.programs.graphical.apps.retroarch;
in
{
  options.${namespace}.programs.graphical.apps.retroarch = {
    enable = lib.mkEnableOption "retroarch";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.retroarch.withCores (
        cores: with cores; [
          beetle-psx-hw
          bsnes
          citra
          dolphin
          dosbox
          genesis-plus-gx
          mame
          mgba
          nestopia
          pcsx2
          snes9x
        ]
      ))
    ];
  };
}
