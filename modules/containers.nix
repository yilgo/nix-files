# enable container support and install related tools
{ pkgs, ... }:

{
  virtualisation.containers.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = [
    pkgs.skopeo
    pkgs.buildah
  ];
}

