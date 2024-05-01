{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  system,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.internal) mkBoolOpt;

  cfg = config.khanelinix.desktop.addons.swaync;

  settings = import ./settings.nix {
    inherit
      config
      inputs
      lib
      osConfig
      pkgs
      system
      ;
  };
  style = import ./style.nix;
in
{
  options.khanelinix.desktop.addons.swaync = {
    enable = mkBoolOpt false "Whether to enable swaync in the desktop environment.";
  };

  config = mkIf cfg.enable {
    services.swaync = {
      enable = true;
      package = pkgs.swaynotificationcenter;

      inherit settings;
      inherit (style) style;
    };
  };
}