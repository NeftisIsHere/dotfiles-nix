{ config, ... }:

{
  fileSystems."/mnt/data" =
    { device = "/dev/disk/by-uuid/3D6EBEC95D9AB4A0";
      fsType = "ntfs3";
      options = [ "rw" "uid=1001" "gid=100" "umask=0022" "prealloc" "nofail" "relatime" ];
    };
}
