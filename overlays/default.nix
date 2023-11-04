{inputs, ...}: {
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    discord = prev.discord.override {
      withOpenASAR = false;
      withVencord = false;
    };
    emacs = prev.emacs29.override {withGTK3 = false;};
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
