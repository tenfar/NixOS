{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.${namespace}.programs.graphical.wms.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        permission = [
          "${lib.getExe pkgs.grimblast}, screencopy, allow"
          "${lib.getExe pkgs.grim}, screencopy, allow"
          "${lib.getExe pkgs.hyprpicker}, screencopy, allow"
          "${lib.getExe pkgs.${namespace}.record_screen}, screencopy, allow"
          "${lib.getExe config.wayland.windowManager.hyprland.portalPackage}, screencopy, allow"
          "${lib.getExe config.programs.hyprlock.package}, screencopy, allow"
        ];
      };
    };
  };
}
