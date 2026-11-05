{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    timeout = 3600;

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = false;
      configurationLimit = 15;
      default = 0;

      extraEntries = ''
        menuentry "Windows" --class windows --class os {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --no-floppy --fs-uuid --set=root ESP_UUID
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
        menuentry "UEFI Firmware Settings" --class efi {
          fwsetup
        }
        menuentry "Reboot" --class restart {
          reboot
        }
        menuentry "Shutdown" --class shutdown {
          halt
        }
      '';
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
  environment.systemPackages = [ pkgs.ntfs3g ];
  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixos";

  system.stateVersion = "26.05";
}