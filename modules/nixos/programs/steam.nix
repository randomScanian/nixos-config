{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.steam;
in {
  options.randomscanian.programs.steam = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable support for Steam.";
    };
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    programs.steam.remotePlay.openFirewall = true;
    hardware.steam-hardware.enable = true;
    services.udev.packages = [pkgs.dolphinEmu];
    environment.systemPackages = with pkgs; [
      steam
    ];
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };
  };
}
