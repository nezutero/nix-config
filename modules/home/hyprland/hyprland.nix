{ config, ... }:

{
  home.file.".config/hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      "/home/nezutero/nixos/modules/home/hyprland/hyprland.conf";
}
