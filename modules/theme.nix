{ config, pkgs, lib, ... }:
let
  enabled = config.illogical-impulse.enable;
in
{
  config = lib.mkIf enabled {
    fonts.fontconfig.enable = true;

    home.file.".local/share/icons/MoreWaita" = {
      source = "${pkgs.morewaita-icon-theme}/share/icons";
    };
  };
}
