
{ config, pkgs,  ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];



  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "curio"; # Define your hostname.
  
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true; 
    allowedTCPPorts = [ 8081 ];
  }; 

  time.timeZone = "Europe/Istanbul";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = false;
  services.displayManager.defaultSession = "niri";
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.niri.enable = true;
  services.printing.enable = true;

  programs.bash = {
    shellInit = ''
      export NIXOS_OZONE_WL=1
      export ELECTRON_OZONE_PLATFORM_HINT=wayland
      export OZONE_PLATFORM=:wqwayland
    '';
  };

  services.xserver.xkb = {
    layout = "us,tr";  # multiple layouts
    options = "grp:alt_shift_toggle";  # switch with Alt+Shift
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
    #media-session.enable = true;
  };

  users.users.monad = {
    isNormalUser = true;
    description = "monad";
    extraGroups = [ "networkmanager" "wheel" "kwm" "adbusers"];
    packages = with pkgs; [
    ];
  };
  programs.adb.enable = true; 
 
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.shellAliases = {
    nixconf = "sudo nvim /etc/nixos/configuration.nix"; 
    ll = "ls -alF";
    bwitch = "sudo nixos-rebuild switch";
  };

  environment.systemPackages = with pkgs; [
     vim 
     wget
     git
     tree
     bat
     fzf
     dbus
     swaylock
     fuzzel
     ghostty
     waybar
     swaybg
     nnn
     gcc
     ghc
     obsidian
     rustup
     python3
     (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-gstreamer
          obs-vkcapture
        ];
    })
    tree-sitter
    nodejs_22
  ];

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      cantarell-fonts
      hack-font
      inter
      jetbrains-mono
      liberation_ttf
      monaspace
      noto-fonts
      ubuntu_font_family
    ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"]; 

  system.stateVersion = "25.05"; 

}
