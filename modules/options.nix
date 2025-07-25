illogical-impulse-dotfiles: { config, pkgs, lib, ... }:
with lib;
let
in
{
  options.illogical-impulse = {
    enable = mkEnableOption "Enable illogical-impulse";
    hyprland = {
      monitor = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ",preferred,auto,1" ];
        description = "Monitor preferences for Hyprland";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.hyprland;
        description = "Hyprland package";
      };
      xdgPortalPackage = lib.mkOption {
        type = lib.types.package;
        default = pkgs.xdg-desktop-portal-hyprland;
        description = "xdg-desktop-portal package for Hyprland";
      };
      ozoneWayland.enable = lib.mkEnableOption "Set NIXOS_OZONE_WL=1";
    };

    dotfiles = {
      anyrun.enable = mkEnableOption "Enable illogical-impulse anyrun";
      kitty.enable = mkEnableOption "Enable illogical-impulse kitty";
      fish.enable = mkEnableOption "Enable illogical-impulse fish";
      starship.enable = mkEnableOption "Enable illogical-impulse starship";
      mpv.enable = mkEnableOption "Enable illogical-impulse mpv";
    };
  };

  config = mkMerge [
    (mkIf (config.illogical-impulse.enable) {
      xdg.configFile."Kvantum/Colloid".source = "${illogical-impulse-dotfiles}/.config/Kvantum/Colloid";
      xdg.configFile."matugen".source = "${illogical-impulse-dotfiles}/.config/matugen";
    })
    (mkIf (config.illogical-impulse.enable && config.illogical-impulse.dotfiles.kitty.enable) {
      xdg.configFile."kitty".source = "${illogical-impulse-dotfiles}/.config/kitty";

      home.packages = [ pkgs.kitty ];
    })
    (mkIf (config.illogical-impulse.enable && config.illogical-impulse.dotfiles.fish.enable) {
      xdg.configFile."fish/config.fish".source = "${illogical-impulse-dotfiles}/.config/fish/config.fish";

      home.packages = [ pkgs.fish ];
    })
    (mkIf (config.illogical-impulse.enable && config.illogical-impulse.dotfiles.starship.enable) {
      xdg.configFile."starship.toml".source = "${illogical-impulse-dotfiles}/.config/starship.toml";

      home.packages = [ pkgs.starship ];
    })
    (mkIf (config.illogical-impulse.enable && config.illogical-impulse.dotfiles.fish.enable) {
      xdg.configFile."mpv/mpv.conf".source = "${illogical-impulse-dotfiles}/.config/mpv/mpv.conf";

      home.packages = [ pkgs.mpv ];
    })
    (mkIf (config.illogical-impulse.enable && config.illogical-impulse.import.anyrun.enable) {
      imports = [ (import ./anyrun.nix illogical-impulse-dotfiles) ];
    })
    (mkIf (config.illogical-impulse.enable && config.illogical-impulse.import.hyprland.enable) {
      imports = [ (import ./hyprland.nix illogical-impulse-dotfiles) ];
    })
  ];
}
