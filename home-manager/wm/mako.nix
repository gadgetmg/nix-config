{ config, ... }: {
  services.mako = with config.colorScheme.palette; {
    enable = true;
    anchor = "top-right";
    output = "DP-1";
    borderRadius = 0;
    borderSize = 2;
    defaultTimeout = 5000;
    font = "sans-serif 10";
    width = 500;
    height = 500;
    margin = "5";
    padding = "10";
    icons = true;
    maxIconSize = 64;
    backgroundColor = "#${base00}";
    textColor = "#${base05}";
    borderColor = "#${base0D}";
    extraConfig = ''
      [urgency=low]
      background-color=#${base00}
      text-color=#${base0A}
      border-color=#${base0D}

      [urgency=high]
      background-color=#${base00}
      text-color=#${base08}
      border-color=#${base0D}
    '';
  };
}
