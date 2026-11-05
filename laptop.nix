{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-laptop.nix ];

  boot.loader = {
    timeout = 3;
    systemd-boot = {
      enable = true;
      configurationLimit = 15;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "laptop";

  services.fwupd.enable = true;
  services.thermald.enable = true;

  system.stateVersion = "26.05";
}