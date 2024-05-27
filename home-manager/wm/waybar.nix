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
        };
        memory = {
          format = "${material_icon "󰍛"}{percentage:3}%";
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
      /* Reset theme styles */
      * {
        all: initial;
        border: none;
        border-radius: 0;
        min-width: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
        font-family: monospace;
        box-shadow: none;
      }

      /* Bar */
      window#waybar {
        background-color: transparent;
      }
      window > box {
        padding: 6px 4px;
        background-color: #${base00};
        color: #${base04};
      }
      /* Hover tooltips */
      tooltip {
        background-color: #${base00};
        padding: 4px;
      }
      tooltip label {
        color: #${base04};
        font-family: sans-serif;
      }
      /* Tray pop-up menus */
      #tray menu {
        background-color: #${base00};
      }
      #tray menuitem > label {
        color: #${base04};
        font-family: sans-serif;
      }
      #tray menuitem:hover {
        background-color: #${base03};
      }
      #tray menu separator {
        background-color: #${base03};
        padding-top: 1px;
      }
      .DP-1 #tray menu {
        padding: 4px;
      }
      .DP-1 #tray menuitem {
        padding: 2px 4px;
      }
      .DP-1 #tray separator {
        margin: 2px 0px;
      }
      .DP-2 #tray menu {
        padding: 3px;
      }
      .DP-2 #tray menuitem {
        padding: 1px 3px;
      }
      .DP-2 #tray separator {
        margin: 1px 0px;
      }

      /* Per-output font size */
      .DP-1 * { font-size: 12.5px; }
      .DP-2 * { font-size: 10.5px; }
      .DP-1 #window { font-size: 13.5px; padding-top: 1px; }
      .DP-2 #window { font-size: 11.5px; padding-top: 1px; }

      /* Default module style */
      #workspaces, #mode, #submap, #cpu, #memory, #mpd, #window, #custom-weather, #gamemode > label, #idle_inhibitor, #tray, #network, #pulseaudio, #clock {
        border-radius: 4px;
        padding: 0px 8px;
        margin: 0px 2px;
        color: #${base04};
        background-color: #${base01};
        border: 1px solid #${base01};
      }
      #window {
        border-color: #${base00};
        background-color: #${base00};
        font-weight: bold;
      }

      /* Left workspace buttons */
      #workspaces {
        padding: 0px 4px;
      }
      #workspaces button label {
        padding: 0px 4px;
        margin-top: 2px;
        margin-bottom: 2px;
        color: #${base03};
      }

      #workspaces button.visible label {
        color: #${base04};
      }
      /* Hover effects */
      #workspaces button:hover label {
        background-image: linear-gradient(#${base03}, #${base03});
        background-size: 65% 2px;
        background-position: bottom center;
        background-repeat: no-repeat;
      }
      /* Music */
      #mpd {
        color: #${base03};
      }
      #mpd.playing {
        border-color: #${base0E};
        background-color: mix(#${base00}, #${base0E}, 0.15);
        color: #${base0E};
        font-weight: bold;
      }
      /* Alerts */
      #mode,
      #submap,
      #pulseaudio.sink.sink-muted,
      #pulseaudio.source.source-muted {
        border-color: #${base08};
        background-color: mix(#${base00}, #${base08}, 0.5);
        color: #${base05};
        font-weight: bold;
      }
      #workspaces button.urgent:not(.focused) label {
        color: #${base08};
        font-weight: bold;
      }
      /* Gamemode */
      #gamemode.running > label {
        border-color: #${base0E};
        background-color: mix(#${base00}, #${base0E}, 0.70);
        color: #${base05};
      }
      /* Idle inhibitor */
      #idle_inhibitor.activated {
        border-color: #${base0F};
        background-color: mix(#${base00}, #${base0F}, 0.5);
        color: #${base05};
      }
      /* Time accent */
      #clock.time {
        border-color: #${base0D};
        color: #${base0D};
        background-color: mix(#${base00}, #${base0D}, 0.15);
        font-weight: bold;
      }
    '';
  };
}
