{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.options.theming;
in {
  options.randomscanian.options.theming = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable custom theming";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      qt6ct
    ];
    home.pointerCursor = {
      package = pkgs.volantes-cursors;
      name = "volantes_cursors";
      size = 12;
    };
    gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.volantes-cursors;
        name = "volantes_cursors";
        size = 12;
      };
      iconTheme = {
        package = pkgs.dracula-icon-theme;
        name = "Dracula";
      };
      theme = {
        package = pkgs.dracula-theme;
        name = "Dracula";
      };
    };
    xdg.configFile."Kvantum/Dracula".source = "${inputs.assets}/theming/Dracula";
    xdg.configFile."qt5ct/qt5ct.conf".source = "${inputs.assets}/theming/qt5ct/qt5ct.conf";
    xdg.configFile."Kvantum/Dracula-Solid".source = "${inputs.assets}/theming/Dracula-Solid";
    xdg.configFile."Kvantum/kvantum.kvconfig".source = "${inputs.assets}/theming/kvantum.kvconfig";
    home.sessionVariables."QT_QPA_PLATFORMTHEME" = "qt5ct";
    systemd.user.sessionVariables."QT_QPA_PLATFORMTHEME" = "qt5ct";
    qt = {
      enable = true;
      style.name = "qt5ct";
    };
  };
}
