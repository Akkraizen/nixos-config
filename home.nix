{ config, pkgs, serpantinum, ... }:

{
  imports = [ serpantinum.homeManagerModules.default ];

  home.username = "akkraizen";
  home.homeDirectory = "/home/akkraizen";
  home.stateVersion = "26.05";

  programs.serpantinum = {
    enable = true;
    systemd.enable = true;

    settings = {
      wallpaperDir = "${config.home.homeDirectory}/Pictures/Wallpapers";

      general = {
        language = "ru";
        weatherUnit = "metric";
        weatherInterval = 30;
      };

      bar = {
        position = "top";
        style = "fill";
        workspaceCount = 10;
        modules = {
          left = [ "left" "workspaces" "media" ];
          center = [ [ "timedate" "info" "weather" ] ];
          right = [ "tray" [ "kb" "wifi" "bt" "vol" "bat" ] ];
        };
      };

      theme = {
        fontFamily = "Adwaita Mono";
        borderRadius = 12;
        matugen = true;
      };

      notifications = {
        dnd = false;
        position = "top right";
        sound = true;
      };
    };
  };

  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };

  home.file."Pictures/Wallpapers/.keep".text = "";
  home.file."Pictures/Screenshots/.keep".text = "";

  programs.home-manager.enable = true;
}