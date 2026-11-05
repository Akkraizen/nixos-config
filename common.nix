{ config, lib, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";
  console = {
    font = "cyr-sun16";
    keyMap = "us";
  };

  networking.networkmanager.enable = true;

  users.users.akkraizen = {
    isNormalUser = true;
    description = "akkraizen";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
  nixpkgs.config.allowUnfree = true;

  zramSwap.enable = true;
  services.fstrim.enable = true;

  environment.systemPackages = with pkgs; [
    git nano vim wget curl htop
    efibootmgr pciutils usbutils
  ];
}