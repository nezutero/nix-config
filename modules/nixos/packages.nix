{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim clang clang-tools glibc lua-language-server wget kitty waybar
    rofi zbar libnotify wtype xwayland-satellite
    (pass.withExtensions (exts: with exts; [ pass-otp ]))
    jq hyprpaper dunst btop hypridle hyprlock hyprsunset wl-clipboard grim
    slurp gimp krita wev tmux brightnessctl cliphist yazi ncdu podman
    pavucontrol fastfetch imagemagick fzf eza bat rofi-bluetooth bluez
    bluez-tools jetbrains-mono gruvbox-material-gtk-theme gruvbox-plus-icons
    zsh fd adwaita-icon-theme ripgrep imv mpv git zathura obs-studio
    onlyoffice-desktopeditors tree docker distrobox tuigreet gcc rustc
    python3 cargo gnupg pinentry-curses telegram-desktop signal-desktop
    nodejs go unzip rmpc thunderbird protonmail-bridge killall
    kanagawa-gtk-theme tor-browser
  ];

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
    PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    PASSWORD_STORE_EXTENSIONS_DIR = "/run/current-system/sw/lib/password-store/extensions/";
  };

  fonts = {
    packages = with pkgs; [
      inter noto-fonts noto-fonts-cjk-sans nerd-fonts.jetbrains-mono jetbrains-mono
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" ];
      serif = [ "Noto Serif" ];
      monospace = [ "JetBrainsMono Nerd Font Mono" ];
    };
  };
}
