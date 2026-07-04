{ pkgs, inputs, ... }:
{
  home.packages = [ inputs.noctalia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  home.file.".local/state/noctalia/settings.toml".source = ./settings.toml;
}
