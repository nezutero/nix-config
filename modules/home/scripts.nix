{ pkgs, ... }:
let
  mkScript = name: path: pkgs.writeShellScriptBin name (builtins.readFile path);
in
{
  home.packages = [
    pkgs.rofi-power-menu
    pkgs.yt-dlp

    (mkScript "backlight" ./scripts/backlight.sh)
    (mkScript "battery_notify" ./scripts/battery_notify.sh)
    (mkScript "fzfman" ./scripts/fzfman.sh)
    (mkScript "kobo" ./scripts/kobo.sh)
    (mkScript "rofipass" ./scripts/rofipass.sh)
    (mkScript "temperature" ./scripts/temperature.sh)
    (mkScript "youtube-mpv" ./scripts/youtube-mpv.sh)
    (mkScript "zathura_rofi" ./scripts/zathura_rofi.sh)
  ];
}
