{ pkgs, ... }:
{
  # ── Networking ───────────────────────────────
  networking.networkmanager.enable = true;
  services.resolved.enable = false;
  networking.nameservers = [ "extended.dns.mullvad.net" "194.242.2.6" ];

  # ── Desktop session ──────────────────────────
  services.xserver.xkb = { layout = "us"; variant = ""; };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = false;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      user = "greeter";
    };
  };

  # ── Background services ──────────────────────
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  virtualisation.podman.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc.lib zlib icu ];

  # ── Automated maintenance ────────────────────
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  # --- NixOS-level PAM entry or you can't actually unlock
  security.pam.services = {
    swaylock = {};
    hyprlock = {};
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  xdg.portal.config.common.default = "*";
}
