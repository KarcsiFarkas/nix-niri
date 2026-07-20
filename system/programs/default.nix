_: {
  imports = [
    ./fonts.nix
    ./xdg.nix
    ./steam.nix
  ];

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
  };
}
