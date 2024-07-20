{ pkgs, ... }:

{
  home.packages = with pkgs; [
    onedrive
  ];

  systemd.user.services."onedrive" = {
    Unit = {
      Description = "OneDrive Free Client";
      Documentation = "https://github.com/abraunegg/onedrive";
      After = [
        "home-matt-OneDrive.mount"
        "network-online.target"
      ];
      Requires = "home-matt-OneDrive.mount ";
      Wants = "network-online.target";
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      ProtectSystem = "full";
      PrivateUsers = true;
      PrivateDevices = true;
      ProtectHostname = true;
      ProtectClock = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      RestrictRealtime = true;
      ExecStart = "${pkgs.onedrive}/bin/onedrive --monitor";
      Restart = "on-failure";
      RestartSec = 3;
      RestartPreventExitStatus = 3;
    };
  };
}
