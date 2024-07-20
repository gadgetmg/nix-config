{ inputs, config, pkgs, ... }:

let
  inherit (config) colorScheme;
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableVteIntegration = true;
    autocd = true;
    # defaultKeymap = "vicmd";

    # Adds a script to zsh's startup to change the colorscheme
    initExtra = ''
      sh ${nix-colors-lib.shellThemeFromScheme { scheme = colorScheme; }}
    '';
  };

  programs.starship.enableZshIntegration = true;
  programs.direnv.enableZshIntegration = true;
}
