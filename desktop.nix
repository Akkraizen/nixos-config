{ pkgs, ... }:

{
  programs.niri.enable = true;

  programs.serpantinum.enable = true;
  programs.gpu-screen-recorder.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd niri-session";
      user = "greeter";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.upower.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    nautilus
    xwayland-satellite
    wl-clipboard
    cliphist
    playerctl
    brightnessctl
    pavucontrol
  ];

  fonts = {
    packages = with pkgs; [
      adwaita-fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
      monospace = [ "Adwaita Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}