# nix-niri

NixOS flake for my `aesthetic` host, centered around Niri and a modular
split between `system/` and `home/`.

## What changed

- Migrated to a pure flake/module layout with `flake-parts`.
- Host wiring is now centralized in `hosts/default.nix`.
- `aesthetic` composes `desktop + laptop` module sets from `system/default.nix`.
- User environment modules live under `home/` and are imported directly.
- Security hardening was expanded in `hosts/aesthetic/default.nix` (kernel params,
  sysctls, apparmor, TPM2, systemd coredump restrictions).
- Daily workflow is built around `nh` (`nh os test`, `nh os switch`).

## Layout

```text
.
├─ flake.nix
├─ hosts/
│  ├─ default.nix
│  └─ aesthetic/
├─ system/
│  ├─ core/
│  ├─ hardware/
│  ├─ network/
│  ├─ nix/
│  ├─ programs/
│  └─ services/
├─ home/
│  ├─ editors/
│  ├─ packages/
│  ├─ services/
│  ├─ terminal/
│  └─ xdg-compat.nix
└─ pkgs/
```

## Main stack

- WM: [Niri](https://github.com/YaLTeR/niri/)
- Shell: [Fish](https://fishshell.com/) + [starship](https://github.com/starship/starship)
- Terminals: [Ghostty](https://ghostty.org/) and Foot
- File manager: [Yazi](https://github.com/sxyazi/yazi)
- Editor: [Helix](https://docs.helix-editor.com/)
- Panel/shell: [Noctalia](https://noctalia.dev/)

## Build and test

From the repo root:

```bash
NH_FLAKE=$PWD nh os test --hostname aesthetic
```

Apply:

```bash
NH_FLAKE=$PWD nh os switch --hostname aesthetic
```

Direct flake check (without `nh`):

```bash
nix build .#nixosConfigurations.aesthetic.config.system.build.toplevel
```

## Fresh install (minimal)

```bash
git clone --depth 1 https://github.com/linuxmobile/nix-niri /mnt/etc/nixos
cd /mnt/etc/nixos
nixos-generate-config --dir /mnt/etc/nixos/hosts/aesthetic
rm -f /mnt/etc/nixos/hosts/aesthetic/configuration.nix
nixos-install --flake .#aesthetic
```

## Screenshots

|                           |                           |
| :-----------------------: | :-----------------------: |
| <img src="/assets/1.png"> | <img src="/assets/2.png"> |
| <img src="/assets/3.png"> | <img src="/assets/4.png"> |
| <img src="/assets/5.png"> | <img src="/assets/6.png"> |

## Acknowledgements

- [owl4ce](https://github.com/owl4ce)
- [Ilham25](https://github.com/ilham25)
- [Siduck](https://github.com/siduck)
- [NvChad](https://github.com/NvChad)
- [Rxyhn](https://github.com/rxyhn)
- [HeinzDev](https://github.com/HeinzDev)
- [fufexan](https://github.com/fufexan)
- [AmitGolden](https://github.com/AmitGolden)

## WSL fix that made `nh os test` pass

Root cause was CRLF line endings in `.nix` files (Windows checkout), which broke
generated shell snippets during Nix builds (`$'\r': command not found` in
`atuin-fish-init`).

Run this in WSL from repo root:

```bash
find . -name '*.nix' -type f -print0 | xargs -0 sed -i 's/\r$//'
NH_FLAKE=$PWD nh os test --hostname aesthetic
```

Recommended to prevent recurrence:

```bash
cat > .gitattributes <<'EOF'
*.nix text eol=lf
*.sh text eol=lf
*.fish text eol=lf
*.toml text eol=lf
EOF
```
