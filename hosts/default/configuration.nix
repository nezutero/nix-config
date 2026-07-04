{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  system.stateVersion = "26.05";
}
