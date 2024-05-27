# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.impermanence.nixosModules.impermanence
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager

    # You can also split up your configuration and import pieces of it here:
    ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
  sops.gnupg.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_rsa_key" ];

  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.rollback = {
    description = "Rollback btrfs rootfs";
    wantedBy = [ "initrd.target" ];
    after = [
      "systemd-cryptsetup@root.service"
    ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir /tmp -p
      MNTPOINT=$(mktemp -d)
      (
        mount -t btrfs -o subvol=/ /dev/disk/by-id/dm-name-root "$MNTPOINT"
        trap 'umount "$MNTPOINT"' EXIT
        
        echo "Cleaning root subvolume"
        btrfs subvolume list -o "$MNTPOINT/root" | cut -f9 -d ' ' |
        while read -r subvolume; do
          btrfs subvolume delete "$MNTPOINT/$subvolume"
        done && btrfs subvolume delete "$MNTPOINT/root"

        echo "Restoring blank subvolume"
        btrfs subvolume snapshot "$MNTPOINT/root-blank" "$MNTPOINT/root"
      )
    '';
  };

  boot.kernelModules = [
    # Enable many sensors (try running "sensors" now and see the
    # difference). Module names were found by running "sudo sensors-detect".
    "nct6775"
    # Cilium
    "ip6table_filter"
    "xt_socket"
    "iptable_raw"
    "iptable_nat"
    "iptable_filter"
    "iptable_mangle"
  ];

  # Xbox gamepad support
  hardware.xone.enable = true;
  hardware.xpadneo.enable = true;

  # AMD GPU
  hardware.amdgpu.amdvlk = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];
  # Accelerated video
  environment.variables.VDPAU_DRIVER = "radeonsi";
  environment.variables.LIBVA_DRIVER_NAME = "radeonsi";
  # Use RADV by default
  environment.variables.AMD_VULKAN_ICD = "RADV";
  environment.variables.VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  # Enable OpenCL on Polaris
  environment.variables.ROC_ENABLE_PRE_VEGA = "1";

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.nur

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      extraOptions = ''
        !include ${config.sops.secrets.nixAccessTokens.path}
      '';
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  sops.secrets.nixAccessTokens = {
    mode = "0440";
    group = config.users.groups.keys.name;
  };

  networking.hostName = "carbon";
  networking.hostId = "69058395";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "America/New_York";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound.
  sound.enable = true;
  # Enable sway
  programs.sway.enable = true;
  # dconf
  programs.dconf.enable = true;
  # Allow fuse mounts to be accessible to other users
  programs.fuse.userAllowOther = true;
  # Fonts
  fonts.enableDefaultPackages = false;
  fonts.fontconfig.defaultFonts = {
    monospace = [ ];
    sansSerif = [ ];
    serif = [ ];
  };
  # GVFS for trash support
  services.gvfs.enable = true;
  # ADb support
  programs.adb.enable = true;
  # Wireshark
  programs.wireshark.enable = true;
  # Steam
  programs.steam.enable = true;
  programs.steam.package = pkgs.steam.override {
    # Proton-GE
    extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${pkgs.proton-ge-bin}'";
  };

  # xdg-desktop-portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
  # Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Docker
  virtualisation.docker.enable = true;

  # Security settings
  security.rtkit.enable = true; # for pipewire realtime
  security.pam.services.swaylock = { }; # for swaylock to check passwords
  security.sudo.wheelNeedsPassword = false;
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  # Workaround https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  # Persistence
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/docker"
    ];
    files = [
      # "/etc/machine-id"
      # "/etc/ssh/ssh_host_ed25519_key"
      # "/etc/ssh/ssh_host_ed25519_key.pub"
      # "/etc/ssh/ssh_host_rsa_key"
      # "/etc/ssh/ssh_host_rsa_key.pub"
      # "/etc/zfs/zpool.cache"
    ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
