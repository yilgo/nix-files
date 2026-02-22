# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  pinnedPackages,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    wget
    vim
    # use nodejs for vscode remote ssh. you need to alos integrate it with
    # https://github.com/nix-community/nixos-vscode-server/tree/master
    nodejs
    gopls
    shellcheck
    terraform-ls
    pinnedPackages.kubectl
    pinnedPackages.terraform
    pinnedPackages.go
    nixfmt
    wireguard-tools
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.yilgo = {
    isNormalUser = true;
    home = "/home/yilgo";
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
    hashedPassword = "$y$j9T$UZYTRILXHzHpShr50rBdk0$JmEnPnWen5sYEUmsdWJzVsSP20jlcTgcKxhVVO6MkA8";
  };

  system.stateVersion = "25.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 3;

  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = false;
  };

}
