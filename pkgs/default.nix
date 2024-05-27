# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  flatcolor-base16-gtk-theme = pkgs.callPackage ./flatcolor-base16-gtk-theme { };
  openweathermap-fullfeatured = pkgs.callPackage ./openweathermap-fullfeatured { };
}
