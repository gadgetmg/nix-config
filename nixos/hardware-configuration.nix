# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/ebd9b86a-b2f5-4e98-bae7-89c1a4a07ff7";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/ef9848a6-0bce-45e8-9b0b-43222586c89c";

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/ebd9b86a-b2f5-4e98-bae7-89c1a4a07ff7";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/ebd9b86a-b2f5-4e98-bae7-89c1a4a07ff7";
      fsType = "btrfs";
      options = [ "subvol=@log" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    {
      device = "/dev/disk/by-uuid/ebd9b86a-b2f5-4e98-bae7-89c1a4a07ff7";
      fsType = "btrfs";
      options = [ "subvol=@persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/6E2E-53BE";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-uuid/ebd9b86a-b2f5-4e98-bae7-89c1a4a07ff7";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  swapDevices =
    [{
      device = "/swap/swapfile";
      size = 32 * 1024;
    }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp9s0f0u1u1u1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp38s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
