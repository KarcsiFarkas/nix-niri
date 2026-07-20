{
  pkgs,
  inputs,
  lib,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  opencode-latest = pkgs.opencode.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "1.17.3";

      src = pkgs.fetchFromGitHub {
        owner = "anomalyco";
        repo = "opencode";
        tag = "v${finalAttrs.version}";
        hash = "sha256-Pqj49q8bTwnTQxnlJbqnot7Pvo2K/WbtdEjEsq5P7qo=";
      };

      node_modules = previousAttrs.node_modules.overrideAttrs (_: {
        inherit (finalAttrs) version src;
        outputHash = "sha256-m0uTWu/JrzeUJXkaIlYf8TgrwMmMKwRsELHe5NAKPDY=";
      });

      env = previousAttrs.env // {
        OPENCODE_VERSION = finalAttrs.version;
      };
    }
  );

  codex = pkgs.writeShellApplication {
    name = "codex";
    runtimeInputs = [ (pkgs.nodejs_22 or pkgs.nodejs) ];
    text = ''
      exec npx -y @openai/codex "$@"
    '';
  };

  gemini-latest = pkgs.writeShellApplication {
    name = "gemini-latest";
    runtimeInputs = [ (pkgs.nodejs_22 or pkgs.nodejs) ];
    text = ''
      exec npx -y @google/gemini-cli "$@"
    '';
  };

  zellij-pane-tracker-mcp = pkgs.writeShellApplication {
    name = "zellij-pane-tracker-mcp";
    runtimeInputs = [ pkgs.bun ];
    text = ''
      server="$HOME/.local/share/zellij-pane-tracker/mcp-server/index.ts"
      if [ ! -f "$server" ]; then
        printf 'zellij-pane-tracker MCP server not found at %s\n' "$server" >&2
        printf 'Run install-zellij-pane-tracker first.\n' >&2
        exit 1
      fi

      exec bun run "$server" "$@"
    '';
  };

  hunkPkg =
    if (inputs ? hunk && inputs.hunk.packages ? ${system})
    then inputs.hunk.packages.${system}.default
    else (pkgs.hunk or null);

  antigravityCli =
    if (inputs ? antigravity-nix && inputs.antigravity-nix.packages ? ${system})
    then inputs.antigravity-nix.packages.${system}.google-antigravity-cli
    else (pkgs.google-antigravity-cli or null);

  antigravityPkg =
    if (inputs ? antigravity-nix && inputs.antigravity-nix.packages ? ${system})
    then inputs.antigravity-nix.packages.${system}.default
    else (pkgs.antigravity or null);

  mcpPackages = lib.filter (p: p != null) [
    (pkgs.context7-mcp or null)
    (pkgs.mcp-k8s-go or null)
    (pkgs.mcp-nixos or null)
  ];
in {
  users.users.karixos.packages = lib.filter (p: p != null) [
    opencode-latest
    codex
    gemini-latest
    zellij-pane-tracker-mcp
    hunkPkg
    antigravityCli
    antigravityPkg
  ] ++ mcpPackages;
}
