{
  "$schema" = "/etc/xdg/swaync/configSchema.json";
  positionX = "right";
  positionY = "top";
  cssPriority = "user";
  layer = "top";
  control-center-margin-top = 10;
  control-center-margin-bottom = 0;
  control-center-margin-right = 10;
  control-center-margin-left = 0;
  notification-icon-size = 64;
  notification-body-image-height = 100;
  notification-body-image-width = 200;
  timeout = 10;
  timeout-low = 5;
  timeout-critical = 0;
  fit-to-screen = true;
  control-center-width = 500;
  control-center-height = 600;
  notification-window-width = 500;
  keyboard-shortcuts = true;
  image-visibility = "when-available";
  transition-time = 200;
  hide-on-clear = false;
  hide-on-action = true;
  script-fail-notify = true;
  scripts = { };
  notification-visibility = { };

  widgets = [
    "menubar#label"
    "buttons-grid"
    "volume"
    "mpris"
    "title"
    "dnd"
    "notifications"
  ];

  widget-config = {
    title = {
      text = "Notifications";
      clear-all-button = true;
      button-text = "Clear All";
    };
    dnd = {
      text = "Do Not Disturb";
    };
    label = {
      max-lines = 4;
      text = "Control Center";
    };
    mpris = {
      image-size = 96;
      image-radius = 12;
    };
    "backlight#KB" = {
      label = " ";
      device = "corsair::kbd_backlight";
      subsystem = "leds";
    };
    volume = {
      label = "";
    };
    "menubar#label" = {
      "menu#power-buttons" = {
        label = "";
        position = "right";
        actions = [
          {
            label = " Reboot";
            command = "systemctl reboot";
          }
          {
            label = " Lock";
            command = "swaylock -f ";
          }
          {
            label = " Logout";
            command = "hyprctl exit";
          }
          {
            label = " Shut down";
            command = "systemctl poweroff";
          }
        ];
      };

      "menu#powermode-buttons" = {
        label = "";
        position = "left";
        actions = [
          {
            label = "Performance";
            command = "powerprofilesctl set performance";
          }
          {
            label = "Balanced";
            command = "powerprofilesctl set balanced";
          }
          {
            label = "Power-saver";
            command = "powerprofilesctl set power-saver";
          }
        ];
      };

      "buttons#topbar-buttons" = {
        position = "left";
        actions = [
          {
            label = "";
            command = "grim";
          }
        ];
      };
    };

    buttons-grid = {
      actions = [
        {
          label = "";
          command = "~/.config/rofi/rofi-wifi-menu.sh";
        }
        {
          label = "";
          command = "~/.config/rofi/rofi-bluetooth";
        }
      ];
    };
  };
}
