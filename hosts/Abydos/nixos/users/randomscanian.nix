{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.fish.enable = true;
  users.users.randomscanian = {
    hashedPassword = "$y$j9T$LN21Okj0i0Jn8LkPqS16J.$nFavuaP6YV8sJymOqMqc8Ez6eIwMorbdRilyeRhTJQ0";
    isNormalUser = true;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDii9d3NiyS5Z/Uwgd6PklYbvsaTkEGck8LEXt43O0kYEU48oE9V0Isjr7mHXRAW4FSPSoDSCiy0tWMARx2lQfgcWkbo8XgGgcOlRdizNjP3jxxDzlgk69wG8MpBMnVT69i+4nz8W7LYR/e9eqviRDco294hBQ8cK1NIdo3ZcnywwYce30RG92Kl04E6IE6ka7hhzRuMV8M8hokiHgApi0eHfuRFKOvxuLrQtDeAI/7fda3YDyGT74Gl2UK+bNNSl4lo2vNPxz65gFy20WksXkKJ0Z5DVF1/CjGf7Mi8o5IBjt4PGRpAjGj1AnvecXwWYl6uyk7u3+WCUqPLTIoxQuYvgqagaIyTjXY+Gkm43WKlF2E6n8dln4evjISgzvmMTuXSU7nBdya4NZMXMiIqzLu9wcsjIXTUjioVzAWCOHgXNw7AeWNbz+aoawWnGk8h5uA3ym7x7tJZt1yTOkywJg/pHjnPPn0a2JuBuOHTbEjBHL72A69X2hkLRA5dHEjUAAeGL6xqFTN0dxhQIiamA2suD5YoxHa3csj/OyPj6XF1TwoJyPLm8rbtFW6r++1xkzao4xMDNI+RTTLLoCkNaMO4m17T1ADNFLG5wKd5FOt2RawU9P8CsP9DLcICIyrEUIPj5aZuLSKXrt5FcvJLiMavTuzGdrgHocEZebBX+ntZQ== \“ssh@github.com\""
    ];
    extraGroups = ["wheel" "audio" "video" "storage" "input"];
  };
  home-manager.users.randomscanian = {
    imports = [
      ../../home-manager
    ];
  };
}
