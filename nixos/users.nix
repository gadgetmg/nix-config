{ inputs, specialArgs, config, pkgs, ... }: {

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  sops.secrets."users/matt" = {
    neededForUsers = true;
  };

  users.mutableUsers = false;

  users.users."matt" = {
    hashedPasswordFile = config.sops.secrets."users/matt".path;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAyCuCnOoArBy2Sp1Rx8jOJRGA8436eYt4tpKUcsGmwx gadgetmg@pm.me"
    ];
    # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
    extraGroups = [ "wheel" "networkmanager" "adbusers" "wireshark" "docker" ];
    shell = pkgs.zsh;
  };

  environment.persistence."/persist" = {
    users.matt.directories = [
      ".cache/mesa_shader_cache"
      ".cache/mozilla/firefox"
      ".config/Code"
      ".config/libfm"
      ".config/libreoffice"
      ".config/nvim"
      ".config/pcmanfm"
      ".config/Signal"
      ".config/sops"
      ".config/unity3d/Team17/Overcooked"
      ".config/WebCord"
      ".gnupg/openpgp-revocs.d"
      ".gnupg/private-keys-v1.d"
      ".helm"
      ".krew"
      ".kube"
      ".local/share/applications"
      ".local/share/direnv"
      ".local/share/mpd"
      ".local/share/Paradox Interactive"
      ".local/share/Steam"
      ".local/share/Tabletop Simulator"
      ".local/share/TelegramDesktop"
      ".local/share/Trash"
      ".local/state/wireplumber"
      ".mozilla/firefox"
      ".paradoxlauncher"
      ".steam"
      ".talos"
      "Backups"
      "Desktop"
      "Documents"
      "Downloads"
      "Music"
      "OneDrive"
      "Pictures"
      "Public"
      "ROMs"
      "src"
      "Templates"
      "Videos"
    ];
    users.matt.files = [
      ".config/onedrive/items.sqlite3"
      ".config/onedrive/refresh_token"
      ".gnupg/pubring.kbx"
      ".gnupg/sshcontrol"
      ".gnupg/trustdb.gpg"
      ".krewfile"
      ".ssh/id_ed25519.pub"
      ".ssh/id_ed25519"
      ".ssh/id_rsa.pub"
      ".ssh/id_rsa"
      ".ssh/known_hosts"
    ];
  };

  home-manager = {
    useUserPackages = true;
    users.matt = ../home-manager/home.nix;
    extraSpecialArgs = specialArgs;
  };

  programs.zsh.enable = true;
}
