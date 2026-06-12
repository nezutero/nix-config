{
  config,
  pkgs,
  lib,
  ...
}:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  home.username = "nezutero";
  home.homeDirectory = "/home/nezutero";
  home.stateVersion = "26.05";

  home.activation.bootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # ── SSH key ──────────────────────────────────────────────────
    if [ ! -f "${config.home.homeDirectory}/.ssh/id_ed25519" ]; then
        mkdir -p "${config.home.homeDirectory}/.ssh"
            chmod 700 "${config.home.homeDirectory}/.ssh"

            ${pkgs.openssh}/bin/ssh-keygen \
            -t ed25519 \
            -C "me@nezutero.dev" \
            -f "${config.home.homeDirectory}/.ssh/id_ed25519" \
            -N ""

            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "  SSH key generated — add to GitHub:"
            echo "  https://github.com/settings/ssh/new"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            cat "${config.home.homeDirectory}/.ssh/id_ed25519.pub"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            fi

            # ── Repos (HTTPS, no auth needed for public repos) ───────────
            if [ ! -d "${config.home.homeDirectory}/dotfiles" ]; then
                ${pkgs.git}/bin/git clone \
                    https://github.com/nezutero/dotfiles.git \
                    "${config.home.homeDirectory}/dotfiles"
            fi

            if [ ! -d "${config.home.homeDirectory}/nvim" ]; then
                ${pkgs.git}/bin/git clone \
                    https://github.com/nezutero/nvim.git \
                    "${config.home.homeDirectory}/nvim"
            fi
  '';

  home.activation.zenBrowser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ZEN_PROFILE="$HOME/.config/zen/zr7hisqa.Default Profile"

    if [ -d "$ZEN_PROFILE" ]; then
        mkdir -p "$ZEN_PROFILE/chrome"

            ln -sf "$HOME/dotfiles/other/zen/user.js" \
            "$ZEN_PROFILE/user.js"

            ln -sf "$HOME/dotfiles/other/zen/chrome/userChrome.css" \
            "$ZEN_PROFILE/chrome/userChrome.css"
            fi
  '';

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
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    BROWSER = "zen-beta";
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "z"
        "tmux"
      ];
      theme = "robbyrussell";
    };

    shellAliases = {
      q = "exit";
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      c = "clear";
      gtp = "cd $HOME/projs && clear && ls -a";
      gtd = "cd $HOME/dotfiles";
      gtc = "cd $HOME/.config";
      gtn = "cd $HOME/notes";
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gcm = "git commit -m";
      gcb = "git checkout -b";
      gco = "git checkout";
      gpl = "git pull";
      gps = "git push";
      gcl = "git clone";
      gbd = "git branch -D";
      gbs = "git switch";
      f = "$HOME/dotfiles/scripts/fzfman.sh";
      cht = "$HOME/dotfiles/scripts/chtman.sh";
      timer = "$HOME/dotfiles/scripts/timer.sh";
      mnt = "udisksctl mount -b /dev/sda1";
      umnt = "udisksctl unmount -b /dev/sda1";
      cdf = "cd /run/media/nezutero/KINGSTON";
      ls = "eza";
      cat = "bat";
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
        name = "nezutero";
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
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  # points symlinks -> ~/dotfiles
  xdg.configFile = {
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nvim";
    "hypr".source = link "hypr";
    "waybar".source = link "waybar";
    "alacritty".source = link "alacritty";
    "ghostty".source = link "ghostty";
    "dunst".source = link "dunst";
    "rofi".source = link "rofi";
    "kitty".source = link "kitty";
    "mpv".source = link "mpv";
    "tmux".source = link "tmux";
    "yazi".source = link "yazi";
    "imv".source = link "imv";
    "fastfetch".source = link "fastfetch";
    "rmpc".source = link "rmpc";
  };

  services.mpd = {
    enable = true;

    musicDirectory = "/home/nezutero/music";

    extraConfig = ''
      restore_paused "no"

      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';

    network = {
      listenAddress = "127.0.0.1";
      port = 6600;
    };
  };

  programs.rmpc = {
    enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Inter";
      size = 12;
    };

    theme = {
      name = "Kanagawa-BL";
      package = pkgs.kanagawa-gtk-theme;
    };

    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };
}
