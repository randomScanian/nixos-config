{
  config,
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}:
with lib; let
  cfg = config.randomscanian.programs.emacs;
in {
  options.randomscanian.programs.emacs = with types; {
    enable = mkOption {
      type = bool;
      default = false;
      example = true;
      description = "Whether or not to enable support for Emacs and its client.";
    };
    defaultEditor = mkOption {
      type = bool;
      default = true;
      example = false;
      description = "Whether or not to use emacs as the default editor";
    };
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs29;
      extraPackages = epkgs: [epkgs.vterm];
    };
    home.sessionVariables."EDITOR" = "emacs -nw";
    systemd.user.sessionVariables."EDITOR" = "emacs -nw";

    home.sessionVariables."VISUAL" = "emacsclient -a 'emacs'";
    systemd.user.sessionVariables."VISUAL" = "emacsclient -a 'emacs'";
    services.emacs = {
      enable = true;
    };
    home.packages = with pkgs; [
      emacs-all-the-icons-fonts
    ];
  };
}
