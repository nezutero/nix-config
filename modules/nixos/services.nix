{ pkgs, ... }:
{
  # ── Networking ───────────────────────────────
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  services.resolved.enable = false;
  networking.nameservers = [ "127.0.0.1" ];

  # ── Desktop session ──────────────────────────
  services.xserver.xkb = { layout = "us"; variant = ""; };
  programs.hyprland.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
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
}
