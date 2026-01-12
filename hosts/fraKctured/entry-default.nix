{ config, lib, pkgs, inputs, ... }:

{
    boot.loader.systemd-boot = {
        extraInstallCommands = ''
	    default_cfg=$(${pkgs.coreutils}/bin/cat /boot/loader/loader.conf | ${pkgs.gnugrep}/bin/grep default | ${pkgs.gawk}/bin/awk '{print $2}')
	    tmp=$(${pkgs.coreutils}/bin/mktemp -d)

	    ${pkgs.coreutils}/bin/echo -ne "$default_cfg\0" | ${pkgs.iconv}/bin/iconv -f utf-8 -t utf-16le > $tmp/efivar.txt
	    ${pkgs.efivar}/bin/efivar -n 4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntryLastBooted -w -f $tmp/efivar.txt
	    ${pkgs.systemd}/bin/bootctl set-default @saved
        '';
    };
}
