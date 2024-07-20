{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    mpc-cli
    pulseaudio
    qalculate-gtk
    veracrypt
    pcmanfm
    libreoffice-fresh
    signal-desktop
    tdesktop # telegram-desktop
    filezilla
    webcord
    wineWowPackages.waylandFull
    jmtpfs
    lm_sensors
    ranger
    trash-cli
    protontricks
  ];

  programs.chromium.enable = true;
  programs.fzf.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.less.enable = true;
  programs.mangohud.enable = true;
  programs.ncmpcpp.enable = true;
  programs.ssh.enable = true;
  programs.zathura.enable = true;

  imports = [
    ./btop.nix
    ./firefox.nix
    ./fonts.nix
    ./git.nix
    ./gtk.nix
    ./gpg.nix
    ./mpd.nix
    ./neovim.nix
    ./onedrive.nix
    ./qt.nix
    ./vscode.nix
    ./wal.nix
  ];

  xdg.configFile."ranger/rc.conf".text = ''
    map DD shell trash %s
  '';

  xdg.mimeApps.enable = true;
}
