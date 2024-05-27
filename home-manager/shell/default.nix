{
  imports = [
    ./bash.nix
    ./zsh.nix
    ./starship.nix
    ./direnv.nix
  ];

  programs.bat.enable = true;
  home.shellAliases = {
    "cat" = "bat";
    "c" = "bat";
    "cy" = "bat -l yaml";
    "g" = "git";
    "k" = "kubectl";
    "l" = "ls";
    "ll" = "ls -l";
    "la" = "ls -la";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
