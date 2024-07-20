{
  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "pipewire"
      }
    '';
  };
}
