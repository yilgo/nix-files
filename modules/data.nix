{ ... }:

{
  systemd.tmpfiles.rules = [
    "d /data/projects 0755 yilgo users - -"
  ];
}
