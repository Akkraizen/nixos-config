{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    timeout = 3600;
    systemd.enabled = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
  environment.systemPackages = [ pkgs.ntfs3g ];
  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixos";

  system.stateVersion = "26.05";
}