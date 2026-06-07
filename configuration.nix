# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.supportedLocales = [
	  "en_US.UTF-8/UTF-8"
	  "en_GB.UTF-8/UTF-8"
	  "fr_FR.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."nezutero" = {
    isNormalUser = true;
    description = "nezutero";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     wget
     kitty
     waybar
     rofi
     hyprpaper
     dunst
     keepassxc
     btop
     hypridle
     hyprlock
     hyprsunset
     wl-clipboard
     grim
     slurp
     gimp
     nwg-look
     wev
     tmux
     brightnessctl
     cliphist
     yazi
     ncdu
     docker
     pavucontrol
     fastfetch
     imagemagick
     fzf
     eza
     bat
     rofi-bluetooth
     anki
     jetbrains-mono
     gruvbox-material-gtk-theme
     gruvbox-plus-icons
     zsh
     fd
     adwaita-icon-theme
     ripgrep
     imv
     mpv
     git
     vencord
     telegram-desktop
     signal-desktop
     whatsapp-electron
     unzip
     rmpc
     thunderbird
     protonmail-bridge
     killall
     noto-fonts
     kanagawa-gtk-theme
  ];

nix.settings.experimental-features = [ "nix-command" "flakes" ];

environment.variables = {
  XCURSOR_THEME = "Adwaita";
  XCURSOR_SIZE  = "24";
};

fonts.packages = with pkgs; [
  nerd-fonts.jetbrains-mono    # NixOS 24.11+
  jetbrains-mono               # non-nerd version (fallback)
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
programs.hyprland.enable = true;
programs.zsh.enable = true;
programs.ssh.startAgent = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
