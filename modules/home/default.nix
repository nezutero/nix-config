{ lib, pkgs, ... }:
{
  imports = [
    ./zen-browser.nix
    ./xdg.nix

    ./shell.nix
    ./git.nix
    ./ssh.nix
    ./gtk.nix
    ./rmpc.nix
    ./scripts.nix

    ./nvim
    ./hyprland
    ./waybar
    ./noctalia
    ./niri.nix
    ./dunst.nix
    ./kitty.nix
    ./rofi.nix
    ./tmux.nix
    ./zathura.nix
    ./yazi.nix
    ./swaylock.nix
  ];

  home.username = "nezutero";
  home.homeDirectory = "/home/nezutero";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    BROWSER = "zen-beta";
  };
}
