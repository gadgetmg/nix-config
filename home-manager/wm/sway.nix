{ config, pkgs, lib, ... }:

{
  programs.zsh.profileExtra = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec sway -V -d &> ~/sway.log
    fi
  '';

  home.sessionVariables = {
    # WLR_DRM_NO_ATOMIC = "1";
    NIXOS_OZONE_WL = "1";
  };

  wayland.windowManager.sway =
    let
      inherit (config.wayland.windowManager) sway;
      ws_main = "1:main";
      ws_www = "2:www";
      ws_chat = "3:chat";
      ws_steam = "4:steam";
      ws_5 = "5:misc";
      ws_6 = "6:misc";
      ws_7 = "7:misc";
      ws_8 = "8:misc";
      ws_9 = "9:misc";
      ws_10 = "10:misc";
      ws_game = "0:game";
    in
    {
      enable = true;
      systemd.enable = true;
      wrapperFeatures.gtk = true;
      config = {
        modifier = "Mod4";
        terminal = "foot";
        menu = "rofi -show drun -theme launcher";
        fonts = {
          names = [ "monospace" ];
          size = 8.5;
        };
        output = {
          "PanaScope Pixio PX277P Unknown" = {
            mode = "2560x1440@165Hz";
            adaptive_sync = "on";
            pos = "0 240";
          };
          "HP Inc. HP E243d CNC103241L" = {
            mode = "1920x1080@60Hz";
            transform = "270";
            pos = "2560 0";
          };
          "*" = {
            #bg = "/home/matt/Pictures/Wallpapers/1.jpg fill";
            bg = "#${config.colorScheme.palette.base01} solid_color";
          };
        };
        workspaceOutputAssign = [
          { workspace = ws_main; output = "DP-1"; }
          { workspace = ws_www; output = "DP-1"; }
          { workspace = ws_chat; output = "DP-2"; }
          { workspace = ws_steam; output = "DP-2"; }
          { workspace = ws_game; output = "DP-1"; }
        ];
        seat."*" = {
          pointer_constraint = "disable";
          hide_cursor = "when-typing enable";
        };
        input."type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        input."type:keyboard" = {
          repeat_delay = "500";
          repeat_rate = "50";
        };
        keybindings =
          let
            mod = sway.config.modifier;
            alt = "Mod1";
            inherit (sway.config) left down up right menu terminal;
          in
          {
            # Start a terminal
            "${mod}+Return" = "exec ${terminal}";

            # Kill focused window
            "${mod}+Shift+q" = "kill";

            # Launchers
            "${mod}+d" = "exec \"${menu}\"";
            "${mod}+equal" = "exec qalculate-gtk";

            # Reload the configuration file
            "${mod}+Shift+c" = "reload";

            # Restart sway
            "${mod}+Shift+r" = "restart";

            # Exit sway (logs you out of your wayland session)
            "${mod}+Shift+e" = "exec rofi -show powermenu -theme powermenu";

            # Move your focus around
            "${mod}+${left}" = "focus left";
            "${mod}+${down}" = "focus down";
            "${mod}+${up}" = "focus up";
            "${mod}+${right}" = "focus right";
            # Arrow keys version
            "${mod}+Left" = "focus left";
            "${mod}+Down" = "focus down";
            "${mod}+Up" = "focus up";
            "${mod}+Right" = "focus right";

            # Move the focused window with the same, but add Shift
            "${mod}+Shift+${left}" = "move left";
            "${mod}+Shift+${down}" = "move down";
            "${mod}+Shift+${up}" = "move up";
            "${mod}+Shift+${right}" = "move right";
            # Arrow keys version
            "${mod}+Shift+Left" = "move left";
            "${mod}+Shift+Down" = "move down";
            "${mod}+Shift+Up" = "move up";
            "${mod}+Shift+Right" = "move right";

            # Switch to workspace
            "${mod}+1" = "workspace number ${ws_main}";
            "${mod}+2" = "workspace number ${ws_www}";
            "${mod}+3" = "workspace number ${ws_chat}";
            "${mod}+4" = "workspace number ${ws_steam}";
            "${mod}+5" = "workspace number ${ws_5}";
            "${mod}+6" = "workspace number ${ws_6}";
            "${mod}+7" = "workspace number ${ws_7}";
            "${mod}+8" = "workspace number ${ws_8}";
            "${mod}+9" = "workspace number ${ws_9}";
            "${mod}+0" = "workspace number ${ws_10}";
            "${mod}+g" = "workspace number ${ws_game}";

            # Move focused container to workspace
            "${mod}+Shift+1" = "move container to workspace number ${ws_main}, workspace number ${ws_main}";
            "${mod}+Shift+2" = "move container to workspace number ${ws_www}, workspace number ${ws_www}";
            "${mod}+Shift+3" = "move container to workspace number ${ws_chat}, workspace number ${ws_chat}";
            "${mod}+Shift+4" = "move container to workspace number ${ws_steam}, workspace number ${ws_steam}";
            "${mod}+Shift+5" = "move container to workspace number ${ws_5}, workspace number ${ws_5}";
            "${mod}+Shift+6" = "move container to workspace number ${ws_6}, workspace number ${ws_6}";
            "${mod}+Shift+7" = "move container to workspace number ${ws_7}, workspace number ${ws_7}";
            "${mod}+Shift+8" = "move container to workspace number ${ws_8}, workspace number ${ws_8}";
            "${mod}+Shift+9" = "move container to workspace number ${ws_9}, workspace number ${ws_9}";
            "${mod}+Shift+0" = "move container to workspace number ${ws_10}, workspace number ${ws_10}";
            "${mod}+Shift+g" = "move container to workspace number ${ws_game}, workspace number ${ws_game}";

            # You can "split" the current object of your focus with
            # ${mod}+b or ${mod}+v, for horizontal and vertical splits
            # respectively.
            "${mod}+b" = "splith";
            "${mod}+v" = "splitv";

            # Switch the current container between different layout styles
            "${mod}+s" = "layout stacking";
            "${mod}+w" = "layout tabbed";
            "${mod}+e" = "layout toggle split";

            # Make the current focus fullscreen
            "${mod}+f" = "fullscreen";

            # Toggle the current focus between tiling and floating mode
            "${mod}+Shift+space" = "floating toggle";

            # Swap focus between the tiling area and the floating area
            "${mod}+space" = "focus mode_toggle";

            # Move focus to the parent container
            "${mod}+a" = "focus parent";

            # Focus next workspace
            "${alt}+Tab" = "workspace next_on_output";

            # Focus other output
            "${mod}+Tab" = "focus output right";

            # Move workspace to other output
            "${mod}+Shift+Tab" = "move workspace to output right";

            # Move the currently focused window to the scratchpad
            "${mod}+Shift+minus" = "move scratchpad";

            # Cycle scratchpad windows
            "${mod}+minus" = "scratchpad show";

            # Screenshots
            "Print" = "exec grimshot --notify copy output";
            "${alt}+Print" = "exec grimshot --notify copy active";
            "${mod}+Shift+s" = "exec grimshot --notify copy area";

            # Media keys
            "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

            # Modes
            "${mod}+r" = "mode resize";
          };
        modes =
          let
            inherit (config.wayland.windowManager.sway.config)
              left down up right;
          in
          {
            resize = {
              ${left} = "resize shrink width 10 px or 10 ppt";
              ${right} = "resize grow width 10 px or 10 ppt";
              ${up} = "resize shrink height 10 px or 10 ppt";
              ${down} = "resize grow height 10 px or 10 ppt";
              Return = "mode default";
              Escape = "mode default";
            };
          };
        bars = [ ];
        gaps = {
          inner = 6;
          smartBorders = "no_gaps";
        };
        colors = with config.colorScheme.palette; {
          background = "#${base07}";
          focused = { border = "#${base0D}"; background = "#${base0D}"; text = "#${base00}"; indicator = "#${base0E}"; childBorder = "#${base0D}"; };
          focusedInactive = { border = "#${base02}"; background = "#${base02}"; text = "#${base05}"; indicator = "#${base02}"; childBorder = "#${base02}"; };
          unfocused = { border = "#${base02}"; background = "#${base02}"; text = "#${base05}"; indicator = "#${base02}"; childBorder = "#${base02}"; };
          urgent = { border = "#${base08}"; background = "#${base08}"; text = "#${base00}"; indicator = "#${base08}"; childBorder = "#${base08}"; };
          placeholder = { border = "#${base00}"; background = "#${base00}"; text = "#${base05}"; indicator = "#${base00}"; childBorder = "#${base00}"; };
        };
        focus = {
          mouseWarping = false;
          newWindow = "focus";
        };
        assigns = {
          ${ws_www} = [
            { app_id = "^firefox$"; }
            { app_id = "^chromium-browser$"; }
          ];
          ${ws_chat} = [
            { app_id = "^org.telegram.desktop$"; }
            { app_id = "^signal$"; }
            { class = "^Signal$"; }
            { app_id = "^WebCord$"; }
            { class = "^steam$"; title = "Friends List"; }
          ];
          ${ws_steam} = [
            { class = "^steam$"; title = "^Steam$"; }
            { title = "^BakkesModInjectorCpp$"; }
          ];
        };
        window = {
          titlebar = false;
          hideEdgeBorders = "smart";
          commands =
            let
              game_command = "move to workspace number ${ws_game}, fullscreen enable, border none, focus";
              game_launcher_command = "move to workspace number ${ws_game}, floating enable, border none, focus";
            in
            [
              # Focus windows on launch
              { criteria.workspace = ""; command = "focus"; }

              # Tabbed chat workspace
              { criteria.workspace = ws_chat; command = "layout tabbed"; }

              # Games
              { criteria.app_id = "^steam_|gamescope"; command = game_command; }
              { criteria.class = "^steam_|gamescope|^stellaris$"; criteria.title = "^(?!Bakkes|Wine)"; command = game_command; }
              { criteria.class = "Paradox Launcher"; command = game_launcher_command; } # Paradox Launcher

              # Wine System Tray
              { criteria.title = "^Wine System Tray$"; command = "kill"; }

              # Volume Control
              { criteria.app_id = "pavucontrol"; command = "sticky enable, resize set 600 700 "; }

              # Qalculate
              { criteria.app_id = "qalculate-gtk"; command = "sticky enable, resize set 351 477"; }

              # fullscreen idle inhibit
              { criteria.class = "^.*"; command = "inhibit_idle fullscreen"; }
              { criteria.app_id = "^.*"; command = "inhibit_idle fullscreen"; }
            ];
        };
        floating = {
          titlebar = true;
          criteria = [
            { window_role = "pop-up"; }
            { title = "^BakkesModInjectorCpp$"; }
            { app_id = "firefox"; title = "^Picture-in-Picture$"; }
            { app_id = "firefox"; title = "^Extension:"; }
            { app_id = "thunar"; title = "^File Operation Progress$"; }
            { app_id = "xarchiver"; }
            { app_id = "veracrypt"; }
            { app_id = "pavucontrol"; }
            { app_id = "qalculate-gtk"; }
            { class = "Steam"; title = "^Steam - Self Updater$"; }
          ];
        };
        startup = [
          { command = "xrandr --output XWAYLAND0 --primary"; }
          { command = "pgrep mako || mako"; always = true; }
          { command = "steam -silent"; }
          { command = "sleep 2 && telegram-desktop -startintray"; }
          # electron apps must start after steam as steam will break them, causing them to open a second instance
          { command = "sleep 10 && signal-desktop --start-in-tray"; }
          { command = "sleep 10 && webcord --start-minimized"; }
        ];
      };
    };
}
