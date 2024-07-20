{ config, lib, pkgs, ... }:

let
  material_icon = icon: "<span font='Material Design Icons'>${icon}</span>";
  material_icon_big = icon: "<span font='Material Design Icons' font_size='150%'>${icon}</span>";
in
rec {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true;
    settings = {
      primary = {
        layer = "top";
        position = "top";
        height = 43;
        modules-left = [
          "gamemode"
        ] ++ (lib.optionals config.wayland.windowManager.sway.enable [
          "sway/workspaces"
          "sway/mode"
        ]) ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
          "hyprland/workspaces"
          "hyprland/submap"
        ]) ++ [
          "cpu"
          "memory"
          "mpd"
        ];
        modules-center = [
        ] ++ (lib.optionals config.wayland.windowManager.sway.enable [
          "sway/window"
        ]) ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
          "hyprland/window"
        ]) ++ [
        ];
        modules-right = [
          "custom/weather"
          "idle_inhibitor"
          "tray"
          "network"
          "pulseaudio#sink"
          "pulseaudio#source"
          "clock#date"
          "clock#time"
        ];
        "sway/window" = {
          format = "{}";
          max-length = 150;
          all-outputs = true;
        };
        cpu = {
          interval = 2;
          format = "${material_icon "󰘚"}{usage:3}%";
          states = {
            warning = 80;
            critical = 90;
          };
        };
        memory = {
          interval = 2;
          format = "${material_icon "󰍛"}{percentage:3}%";
          states = {
            warning = 70;
            critical = 80;
          };
        };
        gamemode = {
          use-icon = false;
          icon-spacing = 0;
          icon-sizing = 0;
          icon-size = 0;
          glyph = "${material_icon "󰊗"}";
          format = "{glyph}";
          format-alt = "{glyph}";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "${material_icon "󰛊"}";
            deactivated = "${material_icon "󰾫"}";
          };
        };
        tray = {
          icon-size = 12;
          spacing = 8;
        };
        network = {
          interval = 2;
          format-ethernet = "${material_icon "󰈀"}";
          tooltip-format-ethernet = ''
            {ifname}
            {ipaddr}/{cidr}
            tx: {bandwidthUpBits}
            rx: {bandwidthDownBits}'';
          format-wifi = "{icon}";
          tooltip-format-wifi = ''
            {ifname}: {essid} ({frequency}Ghz)
            {signalStrength}% ({signaldBm}dBm)
            {ipaddr}/{cidr}
            tx: {bandwidthUpBits}
            rx: {bandwidthDownBits}'';
          format-icons = [
            "${material_icon "󰤟"}"
            "${material_icon "󰤢"}"
            "${material_icon "󰤥"}"
            "${material_icon "󰤨"}"
          ];
          format-disconnected = "${material_icon "󰤮"}";
          tooltip-format-disconnected = "Disconnected";
        };
        "clock#date" = {
          format = "${material_icon "󰃭"} {:%b %d, %Y}";
          interval = 30;
        };
        "clock#time" = {
          format = "${material_icon "󰅐"} {:%I:%M %p}";
          interval = 30;
        };
        "pulseaudio#sink" = {
          format = "{icon}{volume:3}%";
          format-muted = "${material_icon "󰝟"}{volume:3}%";
          format-icons = {
            default = [ "${material_icon "󰕿"}" "${material_icon "󰖀"}" "${material_icon "󰕾"}" ];
          };
          scroll-step = 5;
          on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol -t 3";
          on-click = "${pkgs.pulseaudio}/bin/pactl -- set-sink-mute 0 toggle";
        };
        "pulseaudio#source" = {
          format = "{format_source}";
          format-source = "${material_icon "󰍬"}{volume:3}%";
          format-source-muted = "${material_icon "󰍭"}{volume:3}%";
          on-scroll-up = "${pkgs.pulseaudio}/bin/pactl -- set-source-volume 0 +5%";
          on-scroll-down = "${pkgs.pulseaudio}/bin/pactl -- set-source-volume 0 -5%";
          on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol -t 4";
          on-click = "${pkgs.pulseaudio}/bin/pactl -- set-source-mute 0 toggle";
        };
        "custom/weather" = {
          exec = "${pkgs.openweathermap-fullfeatured}/bin/openweathermap-fullfeatured.sh";
          interval = 300;
        };
        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{title}";
          format-disconnected = "${material_icon "󰝚"} Disconnected";
          format-stopped = "${material_icon "󰝚"} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped";
          unknown-tag = "Unknown";
          state-icons = {
            playing = "${material_icon "󰐊"}";
            paused = "${material_icon "󰏤"}";
          };
          on-click = "${pkgs.mpc-cli}/bin/mpc toggle";
          on-click-right = "${pkgs.mpc-cli}/bin/mpc stop";
          on-scroll-up = "${pkgs.mpc-cli}/bin/mpc volume +5";
          on-scroll-down = "${pkgs.mpc-cli}/bin/mpc volume -5";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = material_icon_big "󰎦";
            "2" = material_icon_big "󰎩";
            "3" = material_icon_big "󰎬";
            "4" = material_icon_big "󰎮";
            "5" = material_icon_big "󰎰";
            "6" = material_icon_big "󰎵";
            "7" = material_icon_big "󰎸";
            "8" = material_icon_big "󰎻";
            "9" = material_icon_big "󰎾";
            "10" = material_icon_big "󰽾";
          };
        };
        "sway/workspaces" = {
          disable-scroll = true;
          disable-markup = true;
          format = "[{index}:{name}]";
          persistent-workspaces = {
            "1:main" = [ "DP-1" ];
            "2:www" = [ "DP-1" ];
            "3:chat" = [ "DP-2" ];
            "4:steam" = [ "DP-2" ];
          };
        };
      };
    };
    style = with config.colorScheme.palette; ''
      @define-color base00 #${base00};
      @define-color base01 #${base01};
      @define-color base02 #${base02};
      @define-color base03 #${base03};
      @define-color base04 #${base04};
      @define-color base05 #${base05};
      @define-color base06 #${base06};
      @define-color base07 #${base07};
      @define-color base08 #${base08};
      @define-color base09 #${base09};
      @define-color base0A #${base0A};
      @define-color base0B #${base0B};
      @define-color base0C #${base0C};
      @define-color base0D #${base0D};
      @define-color base0E #${base0E};
      @define-color base0F #${base0F};
    '' + builtins.readFile ./waybar.css;
  };
}
