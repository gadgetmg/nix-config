{ config, ... }: {
  programs.foot = {
    enable = true;
    settings = with config.colorScheme.palette; {
      main = {
        term = "foot";
        font = "Iosevka Nerd Font:size=10";
        dpi-aware = "no";
        pad = "8x8";
        notify = "none";
        selection-target = "clipboard";
      };
      colors = {
        foreground = "${base05}";
        background = "${base00}";
        regular0 = "${base00}"; # black
        regular1 = "${base08}"; # red
        regular2 = "${base0B}"; # green
        regular3 = "${base0A}"; # yellow
        regular4 = "${base0D}"; # blue
        regular5 = "${base0E}"; # magenta
        regular6 = "${base0C}"; # cyan
        regular7 = "${base05}"; # white
        bright0 = "${base03}"; # bright black
        bright1 = "${base08}"; # bright red
        bright2 = "${base0B}"; # bright green
        bright3 = "${base0A}"; # bright yellow
        bright4 = "${base0D}"; # bright blue
        bright5 = "${base0E}"; # bright magenta
        bright6 = "${base0C}"; # bright cyan
        bright7 = "${base07}"; # bright white
        "16" = "${base09}";
        "17" = "${base0F}";
        "18" = "${base01}";
        "19" = "${base02}";
        "20" = "${base04}";
        "21" = "${base06}";
      };
      cursor = {
        color = "${base00} ${base05}";
      };
      key-bindings = {
        clipboard-copy = "none";
        clipboard-paste = "Control+Shift+v";
      };
      mouse-bindings = {
        primary-paste = "none";
        clipboard-paste = "BTN_MIDDLE";
      };
    };
  };
  systemd.user.services.foot.Install.WantedBy = [ "sway-session.target" ];
}
