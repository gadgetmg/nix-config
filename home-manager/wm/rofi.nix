{ config, pkgs, ... }:

{
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;
  programs.rofi.terminal = "${pkgs.foot}/bin/foot";
  programs.rofi.extraConfig = {
    /*---------- General setting ----------*/
    modi = "drun,run,filebrowser,powermenu:${pkgs.rofi-power-menu}/bin/rofi-power-menu --no-text --choices=lockscreen/logout/suspend/reboot/shutdown --confirm=''";
    case-sensitive = false;
    cycle = true;
    filter = "";
    scroll-method = 0;
    normalize-match = true;
    show-icons = true;
    icon-theme = "Papirus-Dark";
    steal-focus = false;
    hover-select = true;

    /*---------- Matching setting ----------*/
    matching = "normal";
    tokenize = true;

    /*---------- SSH settings ----------*/
    ssh-client = "ssh";
    ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
    parse-hosts = true;
    parse-known-hosts = true;

    /*---------- Drun settings ----------*/
    drun-categories = "";
    drun-match-fields = "name,generic,exec,categories,keywords";
    drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
    drun-show-actions = true;
    drun-url-launcher = "xdg-open";
    drun-use-desktop-cache = false;
    drun-reload-desktop-cache = false;
    /** Parse user desktop files. */
    drun-parse-user = true;
    /** Parse system desktop files. */
    drun-parse-system = true;

    /*---------- Run settings ----------*/
    run-command = "{cmd}";
    run-list-command = "";
    run-shell-command = "{terminal} -e {cmd}";

    /*---------- Fallback Icon ----------*/
    run-fallback-icon = "application-x-addon";
    drun-fallback-icon = "application-x-addon";

    /*---------- Window switcher settings ----------*/
    window-match-fields = "title,class,role,name,desktop";
    window-command = "wmctrl -i -R {window}";
    window-format = "{w} - {c} - {t =0}";
    window-thumbnail = false;

    /*---------- History and Sorting ----------*/
    disable-history = false;
    sorting-method = "normal";
    max-history-size = 25;

    /*---------- Display setting ----------*/
    display-window = "Windows";
    display-windowcd = "Window CD";
    display-run = "Run";
    display-ssh = "SSH";
    display-drun = "Apps";
    display-combi = "Combi";
    display-keys = "Keys";
    display-filebrowser = "Files";

    /*---------- Misc setting ----------*/
    font = "monospace 12";
    sort = false;
    threads = 0;
    click-to-exit = true;

    /*---------- File browser settings ----------*/
    filebrowser-directories-first = true;
    filebrowser-sorting-method = "name";

    /*---------- Other settings ----------*/
    timeout-action = "kb-cancel";
    timeout-delay = 0;
  };

  # programs.rofi.theme = with config.colorScheme.palette; let
  #   inherit (config.lib.formats.rasi) mkLiteral;
  # in {
  #   "*" = {
  #     background-color =  mkLiteral "#${base00}";
  #     border-color = mkLiteral "#${base0D}";
  #     text-color = mkLiteral "#${base05}";
  #     font = "monospace 12";
  #   };
  # };
  xdg.dataFile."rofi/themes/colors.rasi".text = with config.colorScheme.palette; ''
    * {
      base00: #${base00};
      base01: #${base01};
      base02: #${base02};
      base03: #${base03};
      base04: #${base04};
      base05: #${base05};
      base06: #${base06};
      base07: #${base07};
      base08: #${base08};
      base09: #${base09};
      base0A: #${base0A};
      base0B: #${base0B};
      base0C: #${base0C};
      base0D: #${base0D};
      base0E: #${base0E};
      base0F: #${base0F};
    }
  '';
  xdg.dataFile."rofi/themes/launcher.rasi".source = ./launcher.rasi;
  xdg.dataFile."rofi/themes/powermenu.rasi".source = ./powermenu.rasi;
}
