{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./users
  ];

  users = {
    mutableUsers = false;
    users = {
      root.hashedPassword = "$y$j9T$jQe0L4UzJ.g6LClvz7VaE1$sI/ZdyVOwfAbl/nlW9vkbGxJc49B5mzg7nlQc80JhqB";
    };
  };

  # fix home manager.
  programs.dconf.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket";

  services.xserver.layout = "us";
  services.xserver.xkbVariant = "colemak";
  services.xserver.xkbOptions = "eurosign:e,caps:escape";
  console = {
    useXkbConfig = true;
  };

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    background = "${inputs.assets}/theming/wallpaper/first-collection/nixos.png";
    greeters.gtk = {
      enable = true;
      theme = {
        package = pkgs.dracula-theme;
        name = "Dracula";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
      cursorTheme = {
        package = pkgs.nordzy-cursor-theme;
        name = "Nordzy-cursors";
        size = 32;
      };
    };
  };

  services.xserver.windowManager.qtile.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = ["nvidia"];

  randomscanian.programs = {
    steam.enable = true;
    wine.enable = true;
  };

  fonts.packages = with pkgs; [
    emacs-all-the-icons-fonts
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    #gmod-cap-fonts
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      configurationLimit = 20;
      efiSupport = true;
      device = "nodev";
    };
  };

  system.stateVersion = "23.05";
}
