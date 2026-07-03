{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../secrets.nix
  ];

  networking.hostName = "nixos";

  system.stateVersion = "26.05";
}
