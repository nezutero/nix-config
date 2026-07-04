{ pkgs, ... }:
{
  home.file.".config/niri/config.kdl".text = ''
    // ── STATIC WORKSPACES (matches Hyprland's fixed 1-10 behavior) ──────
    workspace "1"
    workspace "2"
    workspace "3"
    workspace "4"
    workspace "5"
    workspace "6"
    workspace "7"
    workspace "8"
    workspace "9"
    workspace "10"

    // ── INPUT ──────────────────────────────────────────────────────────
    input {
        keyboard {
            xkb {
                layout "us,ca"
                options "caps:escape,grp:alt_space_toggle"
            }
        }

        touchpad {
            tap
            dwt
            click-method "clickfinger"
            tap-button-map "left-right-middle"
            natural-scroll
        }

        mouse {
            accel-speed -0.1
        }

        focus-follows-mouse
    }

    prefer-no-csd

    cursor {
        xcursor-theme "Adwaita"
        xcursor-size 48
    }

    environment {
        QT_QPA_PLATFORMTHEME "qt6ct"
        WLR_NO_HARDWARE_CURSORS "1"
    }

    output "eDP-1" {
        mode "1920x1080@60"
        scale 1.25
    }

    layout {
        gaps 0

        border {
            off
        }

        focus-ring {
            off
        }

        default-column-width { proportion 0.5; }
    }

    animations {
        workspace-switch {
            off
        }
    }

    gestures {
        hot-corners {
            // top-left corner opens the overview by default; leave as-is
        }
        dnd-edge-view-scroll {
            trigger-width 30
            delay-ms 100
            max-speed 1500
        }
    }

    blur {
        passes 2
        offset 3.0
        noise 0.03
        saturation 1.0
    }

    layer-rule {
        match namespace="^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
        background-effect {
            xray false
        }
    }

    spawn-at-startup "noctalia"

    window-rule {
        open-maximized true
    }

    window-rule {
        clip-to-geometry true
        background-effect {
            blur true
            xray false
        }
    }

    window-rule {
        match app-id="dev.noctalia.Noctalia.Settings"
        open-floating true
        default-column-width { fixed 1080; }
        default-window-height { fixed 920; }
    }

    binds {
        Mod+Return { spawn "kitty"; }
        Mod+F      { spawn "zen-beta"; }
        Mod+W      { close-window; }
        Mod+E      { spawn "kitty" "-e" "yazi"; }
        Mod+Space  { spawn-sh "noctalia msg panel-toggle launcher"; }
        Mod+P      { spawn-sh "~/dotfiles/scripts/rofipass.sh"; }
        Mod+A      { spawn-sh "GDK_BACKEND=x11 audacity"; }
        Mod+S      { spawn "kitty" "--title" "rmpc" "-e" "sh" "-c" "rmpc update && rmpc"; }
        Mod+D      { spawn "vesktop"; }
        Mod+G      { spawn "signal-desktop"; }
        Mod+H      { spawn-sh "~/dotfiles/scripts/youtube-mpv.sh"; }
        Mod+R      { spawn-sh "~/dotfiles/scripts/zathura_rofi.sh"; }
        Mod+N      { spawn-sh "kitty -d ~/notes"; }

        XF86Tools { spawn-sh "kitty -d ~/dotfiles -e nvim ."; }

        // ── noctalia shell replacements ──────────────────────────────
        // NOTE: this syntax ("noctalia msg <command>") is UNCONFIRMED for
        // your v5.0.0 native build — run `noctalia --help` (and the help
        // for whatever subcommand it shows for runtime control) once the
        // package is actually installed, then swap these strings for the
        // real ones. Everything else in this file is unaffected by that.
        Mod+C         { spawn-sh "noctalia msg panel-toggle clipboard"; }       // was cliphist | rofi
        Mod+B         { spawn-sh "noctalia msg panel-toggle control-center bluetooth"; } // was rofi-bluetooth
        Mod+L         { spawn-sh "noctalia msg session lock"; }                 // was swaylock
        XF86Favorites { spawn-sh "noctalia msg panel-toggle session"; }         // was rofi power-menu
        Mod+M         { spawn-sh "noctalia msg bar-toggle"; }                   // was pkill/relaunch hack
        Mod+Comma     { spawn-sh "noctalia msg settings-toggle"; }
        Mod+Shift+S   { spawn-sh "noctalia msg panel-toggle control-center"; }

        // Alt-Tab style window switching — niri's own built-in overview,
        // guaranteed to work regardless of noctalia's command syntax above.
        Mod+Grave { toggle-overview; }

        // Focus movement
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up    { focus-window-up; }
        Mod+Down  { focus-window-down; }

        // Resizing (mouse: Mod+left-drag = move, Mod+right-drag = resize,
        // built in automatically — only works on non-maximized windows)
        Mod+Minus        { set-column-width "-10%"; }
        Mod+Equal        { set-column-width "+10%"; }
        Mod+Shift+Minus  { set-window-height "-10%"; }
        Mod+Shift+Equal  { set-window-height "+10%"; }
        Mod+Ctrl+R       { switch-preset-column-width; }
        Mod+Ctrl+Shift+R { switch-preset-window-height; }

        // Workspaces (1–10, now static so all exist from startup)
        Mod+1 { focus-workspace "1"; }
        Mod+2 { focus-workspace "2"; }
        Mod+3 { focus-workspace "3"; }
        Mod+4 { focus-workspace "4"; }
        Mod+5 { focus-workspace "5"; }
        Mod+6 { focus-workspace "6"; }
        Mod+7 { focus-workspace "7"; }
        Mod+8 { focus-workspace "8"; }
        Mod+9 { focus-workspace "9"; }
        Mod+0 { focus-workspace "10"; }
        Mod+Tab { focus-workspace-previous; }

        Mod+Shift+1 { move-window-to-workspace "1"; }
        Mod+Shift+2 { move-window-to-workspace "2"; }
        Mod+Shift+3 { move-window-to-workspace "3"; }
        Mod+Shift+4 { move-window-to-workspace "4"; }
        Mod+Shift+5 { move-window-to-workspace "5"; }
        Mod+Shift+6 { move-window-to-workspace "6"; }
        Mod+Shift+7 { move-window-to-workspace "7"; }
        Mod+Shift+8 { move-window-to-workspace "8"; }
        Mod+Shift+9 { move-window-to-workspace "9"; }
        Mod+Shift+0 { move-window-to-workspace "10"; }

        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp   cooldown-ms=150 { focus-workspace-up; }

        Print     { spawn-sh "noctalia msg screenshot-region"; }      // was grim -g "$(slurp)" | wl-copy
        Mod+Print { spawn-sh "noctalia msg screenshot-fullscreen"; }  // was grim -g "$(slurp)" -> file

        XF86MonBrightnessUp        { spawn-sh "noctalia msg brightness-up"; }
        XF86MonBrightnessDown      { spawn-sh "noctalia msg brightness-down"; }
        Mod+XF86MonBrightnessUp    { spawn-sh "noctalia msg brightness-set 100"; }  // was backlight.sh max
        Mod+XF86MonBrightnessDown  { spawn-sh "noctalia msg brightness-set 5"; }    // was backlight.sh min
        Ctrl+XF86MonBrightnessUp   { spawn-sh "noctalia msg nightlight-force-toggle"; }
        Ctrl+XF86MonBrightnessDown { spawn-sh "noctalia msg nightlight-toggle"; }

        // Volume / mic — noctalia's own commands guarantee its OSD shows
        XF86AudioRaiseVolume { spawn-sh "noctalia msg volume-up"; }
        XF86AudioLowerVolume { spawn-sh "noctalia msg volume-down"; }
        XF86AudioMute        { spawn-sh "noctalia msg volume-mute"; }
        XF86AudioMicMute     { spawn-sh "noctalia msg mic-mute"; }

        // Niri "must-haves" not present in the Hyprland file at all —
        // window sizing/fullscreen controls and a safe way to quit.
        Mod+Ctrl+F   { maximize-column; }
        Mod+Shift+F  { fullscreen-window; }
        Mod+Shift+M  { maximize-window-to-edges; }
        Mod+Shift+E  { quit; }

        // Mod+LeftClick drag = move window, Mod+RightClick drag = resize —
        // both are built into niri automatically, no bind needed
        // (this replaces your `bindm` lines).
    }
  '';

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };
}
