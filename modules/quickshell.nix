illogical-impulse-dotfiles: inputs: { config, lib, pkgs, ... }:
let
  cfg = config.illogical-impulse;
in
{
  config = lib.mkIf cfg.enable {
    home.sessionVariables.ILLOGICAL_IMPULSE_VIRTUAL_ENV = "~/.local/state/quickshell/.venv";

    home.packages = with pkgs; [
      inputs.quickshell.packages.${pkgs.system}.default
      kdePackages.kdialog
      kdePackages.qt5compat
      kdePackages.qtbase
      kdePackages.qtdeclarative
      kdePackages.qtdeclarative
      kdePackages.qtimageformats
      kdePackages.qtmultimedia
      kdePackages.qtpositioning
      kdePackages.qtquicktimeline
      kdePackages.qtsensors
      kdePackages.qtsvg
      kdePackages.qttools
      kdePackages.qttranslations
      kdePackages.qtvirtualkeyboard
      kdePackages.qtwayland
      kdePackages.syntax-highlighting
    ];

    xdg.configFile."quickshell".source = "${illogical-impulse-dotfiles}/.config/quickshell";
  };
}
