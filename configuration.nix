# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.resolved.enable = false;
  networking.nameservers = [ "extended.dns.mullvad.net" "194.242.2.6" ];


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

  # Disable resolved to avoid port conflicts
  services.resolved.enable = false;

  # Point DNS to the local NextDNS proxy
  networking.nameservers = [ "127.0.0.1" ];

  # Prevents NM from overriding nameservers
  networking.networkmanager.dns = "none";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."nezutero" = {
    isNormalUser = true;
    description = "nezutero";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    clang
    clang-tools
    glibc
    lua-language-server
    wget
    kitty
    waybar
    rofi
    zbar
    libnotify
    wtype
    (pass.withExtensions (
      exts: with exts; [
        pass-otp
      ]
    ))
    jq
    hyprpaper
    dunst
    btop
    hypridle
    hyprlock
    hyprsunset
    wl-clipboard
    grim
    slurp
    gimp
    krita
    wev
    tmux
    brightnessctl
    cliphist
    yazi
    ncdu
    podman
    pavucontrol
    fastfetch
    imagemagick
    fzf
    eza
    bat
    rofi-bluetooth
    bluez
    bluez-tools
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
    zathura
    obs-studio
    onlyoffice-desktopeditors
    tree
    docker
    distrobox
    tuigreet
    gcc
    rustc
    python3
    cargo
    gnupg
    pinentry-curses
    telegram-desktop
    signal-desktop
    nodejs
    go
    unzip
    rmpc
    thunderbird
    protonmail-bridge
    killall
    kanagawa-gtk-theme
    tor-browser
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
    PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    PASSWORD_STORE_EXTENSIONS_DIR = "/run/current-system/sw/lib/password-store/extensions/";
  };

  fonts = {
    packages = with pkgs; [
      inter
      noto-fonts
      noto-fonts-cjk-sans
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Inter" ];
        serif = [ "Noto Serif" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.hyprland.enable = true;

  programs.zsh.enable = true;

  programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
        user = "greeter";
      };
    };
  };

  virtualisation.podman.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    icu
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # services.udisks2.enable = true;

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
