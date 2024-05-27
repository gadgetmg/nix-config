{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xorg.xrandr
    wlr-randr
  ];

  imports = [
    ./sway.nix
    ./foot.nix
    ./mako.nix
    ./rofi.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
  ];
}
