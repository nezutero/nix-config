{ config, pkgs, ... }:

let
dotfiles = "${config.home.homeDirectory}/dotfiles";
link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
    home.username      = "nezutero";
    home.homeDirectory = "/home/nezutero";
    home.stateVersion  = "26.05";

    home.sessionPath = [
        "$HOME/.local/bin"
            "${config.home.homeDirectory}/dotfiles/scripts"
            "$HOME/.bun/bin"
            "$HOME/.cargo/bin"
            "$HOME/.local/share/cargo/bin"
            "$HOME/.local/share/go/bin"
            "$HOME/go/bin"
    ];

    home.sessionVariables = {
        EDITOR     = "nvim";
        GIT_EDITOR = "nvim";
        VISUAL     = "nvim";
        TERMINAL   = "alacritty";
        BROWSER    = "zen-browser";
    };

    programs.zsh = {
        enable                = true;
        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;

        oh-my-zsh = {
            enable  = true;
            plugins = [ "git" "fzf" "z" "tmux" ];
            theme   = "robbyrussell";
        };

        shellAliases = {
            q = "exit"; v = "nvim"; vi = "nvim"; vim = "nvim"; c = "clear";
            gtp = "cd $HOME/projs && clear && ls -a";
            gtd = "cd $HOME/dotfiles";
            gtc = "cd $HOME/.config";
            gtn = "cd $HOME/notes";
            g = "git"; gs = "git status"; ga = "git add";
            gc = "git commit"; gcm = "git commit -m";
            gcb = "git checkout -b"; gco = "git checkout";
            gpl = "git pull"; gps = "git push"; gcl = "git clone";
            gbd = "git branch -D"; gbs = "git switch";
            f     = "$HOME/dotfiles/scripts/fzfman.sh";
            cht   = "$HOME/dotfiles/scripts/chtman.sh";
            timer = "$HOME/dotfiles/scripts/timer.sh";
            mnt   = "udisksctl mount -b /dev/sda1";
            umnt  = "udisksctl unmount -b /dev/sda1";
            cdf   = "cd /run/media/nezutero/KINGSTON";
            ls = "eza"; cat = "bat";
        };

        initContent = ''
            jn() {
                local title="''${*:-$(date +%Y-%m-%d)}"
                    nvim ~/notes/journal/"$title".md
            }
        '';
    };


    programs.git = {
        enable = true;
        settings = {
            user = {
                name  = "nezutero";
                email = "me@nezutero.dev";
            };
        };
    };

    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
            settings = {
                "*" = {
                    AddKeysToAgent = "yes";
                };
                "github.com" = {
                    HostName     = "github.com";
                    User         = "git";
                    IdentityFile = "~/.ssh/id_ed25519";
                };
            };
    };

# points symlinks -> ~/dotfiles
    xdg.configFile = {
        "nvim".source   	= config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nvim";
        "hypr".source       = link "hypr";
        "waybar".source     = link "waybar";
        "alacritty".source  = link "alacritty";
        "dunst".source      = link "dunst";
        "rofi".source       = link "rofi";
        "kitty".source      = link "kitty";
        "mpv".source        = link "mpv";
        "tmux".source       = link "tmux";
        "yazi".source       = link "yazi";
        "imv".source        = link "imv";
        "fastfetch".source  = link "fastfetch";
    };
}
