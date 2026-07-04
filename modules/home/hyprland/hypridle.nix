{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        { timeout = 600; "on-timeout" = "brightnessctl -e4 -s set 25%"; "on-resume" = "brightnessctl -r"; }
        { timeout = 1200; "on-timeout" = "hyprlock"; }
        { timeout = 1800; "on-timeout" = "hyprctl dispatch dpms off"; "on-resume" = "hyprctl dispatch dpms on"; }
        { timeout = 102400; "on-timeout" = "systemctl suspend"; }
      ];
    };
  };
}
