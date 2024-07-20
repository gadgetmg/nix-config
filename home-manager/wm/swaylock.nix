{ config, pkgs, ... }:

{
  programs.swaylock.enable = true;
  programs.swaylock.settings = with config.colorScheme.palette; {
    color = base00;
    font-size = 12;
    indicator-idle-visible = false;
    indicator-radius = 50;
    show-failed-attempts = true;

    bs-hl-color = base08;
    caps-lock-bs-hl-color = base08;

    inside-color = base00;
    inside-clear-color = base0D;
    inside-caps-lock-color = base0E;
    inside-ver-color = base0C;
    inside-wrong-color = base08;

    key-hl-color = base0C;
    caps-lock-key-hl-color = base0C;

    ring-color = base01;
    ring-clear-color = base01;
    ring-caps-lock-color = base01;
    ring-ver-color = base01;
    ring-wrong-color = base01;
    separator-color = base01;

    line-uses-ring = true;

    text-color = base05;
    text-clear-color = base01;
    text-caps-lock-color = base01;
    text-ver-color = base01;
    text-wrong-color = base01;
  };
}
