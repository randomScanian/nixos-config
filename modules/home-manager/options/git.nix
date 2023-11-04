{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.options.git;
in {
  options.randomscanian.options.git = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable custom git config";
    };
    key = mkOption {
      type = str;
      description = "What key to use";
    };
    userName = mkOption {
      type = str;
      default = "";
      example = "bob";
      description = "The git user name.";
    };
    userEmail = mkOption {
      type = str;
      default = "";
      example = "no@thanks.you";
      description = "The git user email.";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      signing = {
        key = cfg.key;
        signByDefault = true;
      };
      userEmail = cfg.userEmail;
      userName = cfg.userName;
    };
  };
}
