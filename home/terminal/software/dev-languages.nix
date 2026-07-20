{
  pkgs,
  lib,
  ...
}: {
  users.users.karixos.packages = lib.filter (p: p != null) [
    # Python
    (pkgs.python312 or pkgs.python3)
    (pkgs.python312Packages.pip or pkgs.python3Packages.pip)
    (pkgs.python312Packages.virtualenv or pkgs.python3Packages.virtualenv)
    (pkgs.python312Packages.pyyaml or pkgs.python3Packages.pyyaml)
    (pkgs.python314 or null)
    pkgs.uv

    # JavaScript / TypeScript runtimes and package managers
    (pkgs.nodejs_22 or pkgs.nodejs)
    (pkgs.corepack_22 or pkgs.corepack)
    pkgs.pnpm
    pkgs.bun
    pkgs.deno
    pkgs.yarn

    # Go
    pkgs.go
    pkgs.delve

    # Rust
    pkgs.rustup
    pkgs.cargo-nextest
    pkgs.cargo-edit

    # Language Servers (LSPs)
    (pkgs.nixd or null)
    (pkgs.nil or null)
    (pkgs.pyright or null)
    (pkgs.ruff or null)
    (pkgs.typescript or null)
    (pkgs.typescript-language-server or null)
    (pkgs.prettier or null)
    (pkgs.eslint or null)
    (pkgs.gopls or null)
    (pkgs.terraform-ls or null)
    (pkgs.yaml-language-server or null)
    (pkgs.ansible-language-server or null)

    # Linters & Formatters
    pkgs.nixfmt
    pkgs.alejandra
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.yamllint
    pkgs.taplo
    pkgs.pre-commit
  ];
}
