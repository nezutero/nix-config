{ config, ... }:

{
  home.file.".config/hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      "/home/nezutero/dotfiles/hypr/hyprland.conf";
}
