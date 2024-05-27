{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (iosevka-bin.override { variant = "curly"; })
    material-design-icons
    weather-icons
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
  ];

  fonts.fontconfig.enable = true;
  xdg.configFile."fontconfig/conf.d/99-fallback.conf".text = ''
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
    <!-- Fallback fonts preference order -->
    <alias>
      <family>sans-serif</family>
      <prefer>
      <family>Noto Sans</family>
      </prefer>
    </alias>
    <alias>
      <family>serif</family>
      <prefer>
      <family>Noto Serif</family>
      </prefer>
    </alias>
    <alias>
      <family>monospace</family>
      <prefer>
      <family>Iosevka Curly</family>
      </prefer>
    </alias>
    </fontconfig>
  '';
}
