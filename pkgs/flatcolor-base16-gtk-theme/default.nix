{ stdenv, fetchFromGitHub, colorScheme ? null }:

stdenv.mkDerivation {
  name = "flatcolor-base16-gtk-theme";
  src = fetchFromGitHub {
    owner = "deviantfero";
    repo = "wpgtk-templates";
    rev = "4119a9afb27acf9e231c211cdfd12992c318499e";
    sha256 = "sha256-LKIVasIO6ZjuRnY5NEj4NrtHchW8lafsnfh1IiEcoR0=";
  };
  dontBuild = true;
  installPhase = ''
    runHook preInstall

    cd FlatColor

    # loop through all the templates
    for template in $(ls gtk-*/*.base);
    do
      # target file without ".base" on the end
      target=`echo "$template" | sed 's/\.base//'`

      # substitute all variables in $template and write it to $target
      substitute $template $target \
        --replace "{color0}" "#${colorScheme.palette.base00}" \
        --replace "{color1}" "#${colorScheme.palette.base08}" \
        --replace "{color2}" "#${colorScheme.palette.base0B}" \
        --replace "{color3}" "#${colorScheme.palette.base0A}" \
        --replace "{color4}" "#${colorScheme.palette.base0D}" \
        --replace "{color5}" "#${colorScheme.palette.base0E}" \
        --replace "{color6}" "#${colorScheme.palette.base0C}" \
        --replace "{color7}" "#${colorScheme.palette.base05}" \
        --replace "{color8}" "#${colorScheme.palette.base03}" \
        --replace "{color9}" "#${colorScheme.palette.base00}" \
        --replace "{color10}" "#${colorScheme.palette.base0B}" \
        --replace "{color11}" "#${colorScheme.palette.base0A}" \
        --replace "{color12}" "#${colorScheme.palette.base0D}" \
        --replace "{color13}" "#${colorScheme.palette.base0E}" \
        --replace "{color14}" "#${colorScheme.palette.base0C}" \
        --replace "{color15}" "#${colorScheme.palette.base07}" \
        --replace "{active}" "#${colorScheme.palette.base02}" \
        --replace "{{" "{" \
        --replace "}}" "}"

      # remove the template as it isn't needed in the final theme
      rm $template
    done

    mkdir -p $out/share/themes/FlatColor-${colorScheme.slug}
    cp -a . $out/share/themes/FlatColor-${colorScheme.slug}

    runHook postInstall
  '';
}
