{
  pkgs,
  lib,
  ...
}: {
  users.users.karixos.packages = with pkgs; [
    # Core POSIX & Terminal Utilities
    bashInteractive
    coreutils
    curl
    wget
    rsync
    unzip
    zip
    dos2unix
    xz
    gnutar
    gzip
    which
    file
    tree
    less
    man-db
    man-pages
    procps
    psmisc
    lsof
    ncdu
    htop
    btop
    hyperfine
    tokei
    doggo
    bind
    nmap
    tcpdump
    socat
    netcat-openbsd
    jq
    yq-go
    jless
    fx

    # Shell Productivity & Text Tools
    ouch
    delta
    difftastic
    sd
    procs
    dust
    bottom
    direnv
    nix-direnv
  ];
}
