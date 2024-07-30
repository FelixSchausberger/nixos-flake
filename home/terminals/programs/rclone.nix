{
  pkgs,
  secrets,
  ...
}: let
  mountdir = "/per/mnt/gdrive";
in {
  systemd.user.services.gdrive_mount = {
    Unit = {
      Description = "mount gdrive dirs";
      After = ["network-online.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mountdir}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
            --drive-client-id ${secrets.rclone.client-id} \
            --drive-client-secret ${secrets.rclone.client-secret} gdrive: ${mountdir} \
              --dir-cache-time 48h \
              --vfs-cache-mode full \
              --vfs-cache-max-age 48h \
              --vfs-read-chunk-size 10M \
              --vfs-read-chunk-size-limit 512M \
              --buffer-size 512M
      '';
      ExecStop = "/run/wrappers/bin/fusermount -u ${mountdir}";
      Type = "notify";
      Restart = "always";
      RestartSec = "10s";
      Environment = ["PATH=/run/wrappers/bin/:$PATH"];
    };
  };

  # xdg.configFile."rclone/rclone.conf".text = ''
  #   [gdrive]
  #   type = drive
  #   client_id = ${secrets.rclone.client-id}
  #   client_secret = ${secrets.rclone.client-secret}
  #   scope = drive
  #   token = {"access_token":"ya29.a0AXooCguofGElUljwYpY2Z76ixfOSg6W17kWdlPDVTJ3CaRCknDuInOruDe1DAQTYI7Kq2lpsXjifiZ8rwa9MLEa7avKXxOrXDErHcCaPQQvNs5R1SjTiwqiDIvDeQnQpoMGZatrRS6HAIbxqmRUQ8hOLZPW1489VF9eraCgYKAa0SARASFQHGX2Milrd8x6CPx7O9CiJdbJybxQ0171","token_type":"Bearer","refresh_token":"1//09iI8z6c1la8CCgYIARAAGAkSNwF-L9Ir1UJTiH13kzrA4SJeIGewC6yx1JdsBevZNbtum2mgPa-L9x8QPtoeX-0hLQtHbOqNsls","expiry":"2024-07-29T00:46:02.804282034+02:00"}
  #   team_drive =
  # '';
}
