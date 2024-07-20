{ config, ... }:

with config.colorScheme.palette; {
  home.file.".cache/wal/colors.json".text = ''
    {
      "special": {
        "background": "#${base00}",
        "foreground": "#${base05}",
        "cursor":     "#${base05}"
      },
      "colors": {
        "color0":  "#${base00}",
        "color1":  "#${base08}",
        "color2":  "#${base0B}",
        "color3":  "#${base0A}",
        "color4":  "#${base0D}",
        "color5":  "#${base0E}",
        "color6":  "#${base0C}",
        "color7":  "#${base05}",
        "color8":  "#${base03}",
        "color9":  "#${base00}",
        "color10": "#${base0B}",
        "color11": "#${base0A}",
        "color12": "#${base0D}",
        "color13": "#${base0E}",
        "color14": "#${base0C}",
        "color15": "#${base07}"
      }
    }
  '';

  home.file.".cache/wal/colors".text = ''
    #${base00}
    #${base08}
    #${base0B}
    #${base0A}
    #${base0D}
    #${base0E}
    #${base0C}
    #${base05}
    #${base03}
    #${base00}
    #${base0B}
    #${base0A}
    #${base0D}
    #${base0E}
    #${base0C}
    #${base07}
  '';
}
