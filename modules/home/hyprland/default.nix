{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;      # already managed by `programs.hyprland.enable` at the NixOS level
    systemd.enable = false; # you're launching via tuigreet, not a systemd/UWSM session

    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1.25";

      "exec-once" = [
        "waybar & hyprpaper & hypridle & protonmail-bridge --cli"
        "--no-startup-id dunst -config ~/.config/dunst/dunstrc"
        "clipmenud &"
        "~/dotfiles/scripts/battery_notify.sh &"
        "hyprsunset -t 4000"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      env = [
        "XCURSOR_THEME, Adwaita"
        "XCURSOR_SIZE, 24"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "yazi";
      "$menu" = "rofi -show drun";
      "$editor" = "nvim";
      "$browser" = "zen-beta";
      "$player" = "kitty --title rmpc -e sh -c 'rmpc update && rmpc'";
      "$mainMod" = "SUPER";

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "us,ca";
        kb_variant = "";
        kb_model = "";
        kb_options = "caps:escape, grp:alt_space_toggle";
        kb_rules = "";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        gesture = "3, horizontal, workspace";
        sensitivity = -0.1;
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 4, default"
          "borderangle, 1, 3, default"
          "fade, 1, 3, default"
          "workspaces, 0, 0, default"
        ];
      };

      ecosystem = {
        no_update_news = true;
      };

      misc = {
        force_default_wallpaper = 0;
      };

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = 0.2;
        }
      ];

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, F, exec, $browser"
        "$mainMod, W, killactive,"
        "$mainMod, E, exec, $terminal -e $fileManager"
        "$mainMod, B, exec, rofi-bluetooth"
        "$mainMod, H, exec, $HOME/dotfiles/scripts/youtube-mpv.sh"
        "$mainMod, R, exec, $HOME/dotfiles/scripts/zathura_rofi.sh"
        ''$mainMod, N, exec, bash -c "kitty -d $HOME/notes"''
        ''$mainMod, space, exec, $menu & sleep 0.2; hyprctl dispatch focuswindow "^(Rofi)"''
        "$mainMod, P, exec, ~/dotfiles/scripts/rofipass.sh"
        "$mainMod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod, A, exec, GDK_BACKEND=x11 audacity"
        "$mainMod, S, exec, $player"
        "$mainMod, D, exec, vesktop"
        "$mainMod, G, exec, signal-desktop"
        "$mainMod, M, exec, waybar"
        "$mainMod, K, exec, pkill waybar"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, TAB, workspace, prev"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ''
          , Print, exec, grim -g "$(slurp)" - | wl-copy -t image/png && dunstify -a "Screenshot" -u low -r 9001 -t 1500 "Screenshot" "Copied to clipboard"
        ''

        ''
          $mainMod, Print, exec, FILE=~/Pictures/screenshots/$(date +%Y-%m-%d-%H-%M-%S).png && grim -g "$(slurp)" "$FILE" && dunstify -a "Screenshot" -u low -r 9002 -t 1500 "Screenshot Saved" "$FILE"
        ''

      ];

      binde = [
        ", XF86MonBrightnessUp, exec, ~/dotfiles/scripts/backlight.sh up"
        ", XF86MonBrightnessDown, exec, ~/dotfiles/scripts/backlight.sh down"
        "SUPER, XF86MonBrightnessUp, exec, ~/dotfiles/scripts/backlight.sh max"
        "SUPER, XF86MonBrightnessDown, exec, ~/dotfiles/scripts/backlight.sh min"
        "CTRL, XF86MonBrightnessUp, exec, ~/dotfiles/scripts/temperature.sh up"
        "CTRL, XF86MonBrightnessDown, exec, ~/dotfiles/scripts/temperature.sh down"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
        ", XF86Favorites, exec, rofi -show power-menu -modi power-menu:~/dotfiles/scripts/rofi-power-menu.sh"
        ", XF86Tools, exec, kitty -d ~/dotfiles -e nvim ."
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
