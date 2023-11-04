{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home = {
    username = "randomscanian";
    homeDirectory = "/home/randomscanian";
  };
  home.packages = with pkgs; [
    direnv
    discord
  ];

  services.picom = {
    enable = true;
  };

  

  randomscanian = {
    options = {
      xsession = {
        packages = with pkgs; [pulsemixer];
        autostart = ''
          ${pkgs.feh}/bin/feh ${inputs.assets}/theming/wallpaper/first-collection/nixos.png
        '';
      };
      theming.enable = true;
      shell.enable = true;
      git = {
        enable = true;
        key = "4110A238A75F7AA4AEF50C8C15BD05B9BCE4AA02";
        userName = "RandomScanian";
        userEmail = "RandomScanian@protonmail.com";
      };
      aliases = {
        packages = with pkgs; [
          eza
        ];
        aliases = {
          l = "eza -l --icons --grid --time-style long-iso --group-directories-first";
          ll = "eza -lA --icons --grid --time-style long-iso --group-directories-first";
          ls = "eza --icons --grid --time-style long-iso --group-directories-first";
          lsa = "eza -A --icons --grid --time-style long-iso --group-directories-first";
        };
      };
    };
    programs = {
      emacs.enable = true;
      firefox.enable = true;
      prismLauncher.enable = true;
      torrents.enable = true;
      qtile.enable = true;
      alacritty.enable = true;
      fish.enable = true;
    };
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
