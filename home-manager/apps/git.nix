{
  programs.git = {
    enable = true;
    userName = "Matt Graham";
    userEmail = "gadgetmg@pm.me";
    signing = {
      signByDefault = true;
      key = "~/.ssh/id_ed25519.pub";
    };
    extraConfig = {
      init.defaultBranch = "main";
      gpg.format = "ssh";
    };
  };
}
