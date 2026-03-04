{pkgs, ...}: {
  users.users.karixos.packages = with pkgs; [
    alsa-utils
    easyeffects
  ];
}
