{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.torrents;
in {
  options.randomscanian.programs.torrents = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable support for torrents";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [qbittorrent];
  };
}
