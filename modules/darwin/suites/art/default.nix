{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.internal; let
  cfg = config.khanelinix.suites.art;
in
{
  options.khanelinix.suites.art = with types; {
    enable = mkBoolOpt false "Whether or not to enable art configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # blender
      gimp
      inkscape
      imagemagick
      pngcheck
    ];

    homebrew = {
      casks = [
        "inkscape"
        "mediainfo"
      ];

      masApps = mkIf config.khanelinix.tools.homebrew.masEnable {
        "Pixelmator" = 407963104;
      };
    };
  };
}
