{ pkgs, ... }:

{
  home.sessionVariables = {
    MOZ_GTK_TITLEBAR_DECORATION = "client";
    MOZ_ENABLE_WAYLAND = 1;
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "extensions.pocket.enabled" = false;
        #"browser.newtabpage.activity-stream.feeds.system.topsites" = true; # Enable top sites
        "browser.newtabpage.activity-stream.feeds.system.topstories" = false; # Disable Pocket stories

        "browser.tabs.inTitlebar" = 0;

        # New tab page
        #"browser.newtabpage.activity-stream.feeds.topsites" = true; # Enable top sites
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false; # Disable sponsored top sites
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # Disable Pocket stories
        "browser.newtabpage.activity-stream.showSponsored" = false; # Disable sponsored stories
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false; # Disable recent activity

        # "browser.uiCustomization.state" = ''
        # '';

        "signon.rememberSignons" = false;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        decentraleyes
        darkreader
        ublock-origin
        privacy-badger
        bitwarden
        multi-account-containers
        temporary-containers
        terms-of-service-didnt-read
        youtube-shorts-block
        youtube-nonstop
        zoom-redirector
        h264ify
      ];
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };
}
