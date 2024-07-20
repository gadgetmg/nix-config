{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "FlatColor-${config.colorScheme.slug}";
      package = (pkgs.flatcolor-base16-gtk-theme.override {
        colorScheme = config.colorScheme;
      });
    };
    font = {
      name = "sans-serif";
      size = 10;
    };
  };

  home.packages = with pkgs; [
    gtk-engine-murrine
  ];
}
