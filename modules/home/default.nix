{ config, lib, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in
{
    imports = [
            ./bootstrap.nix
            ./zen-browser.nix
            ./xdg.nix

            ./shell.nix
            ./git.nix
            ./ssh.nix
            ./gtk.nix
            ./mpd.nix
            ./rmpc.nix

            ./nvim
            ./hyprland
            ./waybar.nix
            ./alacritty.nix
            ./kitty.nix
            ./dunst.nix
            ./rofi.nix
            ./mpv.nix
            ./tmux.nix
            ./yazi.nix
            ./imv.nix
            ./fastfetch.nix
            ./zathura.nix
        ];

  _module.args.link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";

  home.username = "nezutero";
  home.homeDirectory = "/home/nezutero";
  home.stateVersion = "26.05";

  home.sessionPath = [ "${dotfiles}/scripts" ];

  home.sessionVariables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    BROWSER = "zen-beta";
  };
}
