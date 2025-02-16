{
  config,
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) getExe';
in
{
  "custom/quit" = {
    format = "󰗼";
    tooltip = false;
    "custom/quit" = {
      format = "󰗼";
      tooltip = false;
      on-click =
        if osConfig.programs.uwsm.enable then
          "${getExe' osConfig.programs.uwsm.package "uwsm"} stop"
        else
          "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch exit";
    };
  };

  "hyprland/submap" = {
    format = "✌️ {}";
    max-length = 8;
    tooltip = false;
  };

  "hyprland/window" = {
    format = "{}";
    separate-outputs = true;
  };

  "hyprland/workspaces" = {
    all-outputs = false;
    active-only = "false";
    on-scroll-up = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch workspace e+1";
    on-scroll-down = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch workspace e-1";
    format = "{icon} {windows}";
    format-icons = {
      "1" = "󰎤";
      "2" = "󰎧";
      "3" = "󰎪";
      "4" = "󰎭";
      "5" = "󰎱";
      "6" = "󰎳";
      "7" = "󰎶";
      "8" = "󰎹";
      "9" = "󰎼";
      "10" = "󰽽";
      "urgent" = "󱨇";
      "default" = "";
      "empty" = "󱓼";
    };
    # "format-window-separator" = "->";
    window-rewrite-default = "";
    window-rewrite = {
      "class<.blueman-manager-wrapped>" = "";
      "class<.devede_ng.py-wrapped>" = "";
      "class<.pitivi-wrapped>" = "󱄢";
      "class<.xemu-wrapped>" = "";
      "class<1Password>" = "󰢁";
      "class<Alacritty>" = "";
      "class<Ardour-.*>" = "";
      "class<Bitwarden>" = "󰞀";
      "class<Caprine>" = "󰈎";
      "class<DBeaver>" = "";
      "class<Element>" = "󰭹";
      "class<Darktable>" = "󰄄";
      "class<Github Desktop>" = "󰊤";
      "class<Godot>" = "";
      "class<Mysql-workbench-bin>" = "";
      "class<Nestopia>" = "";
      "class<Postman>" = "󰛮";
      "class<Ryujinx>" = "󰟡";
      "class<Slack>" = "󰒱";
      "class<Spotify>" = "";
      "class<Youtube Music>" = "";
      "class<bleachbit>" = "";
      "class<code>" = "󰨞";
      "class<com.obsproject.Studio" = "󱜠";
      "class<com.usebottles.bottles>" = "󰡔";
      "class<discord>" = "󰙯";
      "class<dropbox>" = "";
      "class<dupeGuru>" = "";
      "class<firefox.*> title<.*github.*>" = "";
      "class<firefox.*> title<.*twitch|youtube|plex|tntdrama|bally sports.*>" = "";
      "class<firefox.*>" = "";
      "class<foot>" = "";
      "class<fr.handbrake.ghb" = "󱁆";
      "class<heroic>" = "󱢾";
      "class<info.cemu.Cemu>" = "󰜭";
      "class<io.github.celluloid_player.Celluloid>" = "";
      "class<kitty>" = "";
      "class<libreoffice-calc>" = "󱎏";
      "class<libreoffice-draw>" = "󰽉";
      "class<libreoffice-impress>" = "󱎐";
      "class<libreoffice-writer>" = "";
      "class<mGBA>" = "󱎓";
      "class<mediainfo-gui>" = "󱂷";
      "class<melonDS>" = "󱁇";
      "class<minecraft-launcher>" = "󰍳";
      "class<mpv>" = "";
      "class<org.gnome.Nautilus>" = "󰉋";
      "class<org.kde.digikam>" = "󰄄";
      "class<org.kde.filelight>" = "";
      "class<org.prismlauncher.PrismLauncher>" = "󰍳";
      "class<org.qt-project.qtcreator>" = "";
      "class<org.shotcut.Shotcut>" = "󰈰";
      "class<org.telegram.desktop>" = "";
      "class<org.wezfurlong.wezterm>" = "";
      "class<pavucontrol>" = "";
      "class<pcsx2-qt>" = "";
      "class<pcsxr>" = "";
      "class<shotwell>" = "";
      "class<steam>" = "";
      "class<tageditor>" = "󱩺";
      "class<teams-for-linux>" = "󰊻";
      "class<thunar>" = "󰉋";
      "class<thunderbird>" = "";
      "class<unityhub>" = "󰚯";
      "class<virt-manager>" = "󰢹";
      "class<looking-glass-client>" = "󱇽";
      "class<vlc>" = "󱍼";
      "class<wlroots> title<.*WL-1.*>" = "";
      "class<xwaylandvideobridge>" = "";
      "code-url-handler" = "󰨞";
      "title<RPCS3.*>" = "";
      "title<Spotify Free>" = "";
      "title<Steam>" = "";
      "class<rustdesk>" = "󰢹";
      "class<org.vinegarhq.Sober>" = "󰆢";
      "class<steam_app.*> title<Battle.net>" = "";
      "class<steam_app.*> title<World of Warcraft>" = "";
      "class<steam_app.*> title<>" = "";
      "class<Wowup-cf>" = "";
      "class<com.mitchellh.ghostty>" = "󰊠";
      "class<org.inkscape.Inkscape>" = "";
    };
  };
  "custom/hyprsunset" = {
    interval = "once";
    exec = "if pgrep hyprsunset >/dev/null 2>&1; then stdbuf -oL printf '{\"alt\": \"on\"}'; else stdbuf -oL printf '{\"alt\": \"off\"}'; fi";
    on-click = "pkill hyprsunset || hyprsunset";
    signal = 1;
    return-type = "json";
    format = "{icon}";
    tooltip-format = "hyprsunset: {alt}";
    format-icons = {
      "off" = "☀️";
      "on" = "🌙";
    };
  };
}
