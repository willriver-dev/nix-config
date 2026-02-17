# NixOS Multi-Host Configuration

NixOS configuration using Nix Flakes for multiple machines, designed for backend development.

## Hosts

| Host | Architecture | Description |
|------|--------------|-------------|
| `wsl` | x86_64-linux | Windows Subsystem for Linux (headless) |
| `laptop` | x86_64-linux | ThinkPad E14 Gen 7 AMD (Niri + GUI) |
| `vm-fusion` | aarch64-linux | VMware Fusion on macOS M1 (Niri + GUI) |

## Installation

### Step 1: Install NixOS

- **WSL**: Download NixOS-WSL from [nix-community/NixOS-WSL](https://github.com/nix-community/NixOS-WSL)
- **Laptop/VM**: Install NixOS from ISO, choose minimal installation

### Step 2: Clone repository

```bash
git clone <repo-url> ~/workspace/nixos-config
cd ~/workspace/nixos-config
```

### Step 3: Configure for each machine

#### Replace hardware config (laptop and vm-fusion only)

```bash
sudo nixos-generate-config --show-hardware-config > ~/hardware.nix
```

Then copy the content to:
- Laptop: `hosts/laptop/hardware.nix`
- VM Fusion: `hosts/vm-fusion/hardware.nix`

### Step 4: Build and apply

```bash
# For WSL
sudo nixos-rebuild switch --flake ~/workspace/nixos-config#wsl

# For Laptop
sudo nixos-rebuild switch --flake ~/workspace/nixos-config#laptop

# For VM Fusion
sudo nixos-rebuild switch --flake ~/workspace/nixos-config#vm-fusion
```

### Step 5: Copy dotfiles

After first build, copy config files to their destinations:

```bash
# Terminals
cp -r config/ghostty   ~/.config/ghostty
cp -r config/alacritty ~/.config/alacritty
cp -r config/kitty     ~/.config/kitty

# Editors
cp -r config/helix ~/.config/helix
cp -r config/nvim  ~/.config/nvim

# Window manager & lock screen (GUI hosts only)
cp -r config/niri ~/.config/niri
cp -r config/hypr ~/.config/hypr

# Git
cp config/git/config ~/.config/git/config

# Bash
cp config/bash/.bashrc ~/.bashrc
```

### Step 6: Setup Rust toolchain

```bash
rustup default stable
rustup component add rust-analyzer
```

## Config management

Nix manages **package installation** only. Application configs live as plain dotfiles in `config/` and are copied manually to `~/.config/`.

**Exceptions** (still managed by Nix):
- `firefox` - profile settings via Home Manager
- `direnv` - bash integration via Home Manager
- `mako` - notification daemon via Home Manager

## Directory Structure

```
nixos-config/
├── flake.nix                     # Entry point: inputs and 3 hosts
├── config/                       # Dotfiles (copy to ~/.config/)
│   ├── alacritty/alacritty.toml
│   ├── bash/.bashrc
│   ├── ghostty/config
│   ├── git/config
│   ├── helix/
│   │   ├── config.toml
│   │   └── languages.toml
│   ├── hypr/
│   │   ├── hyprlock.conf
│   │   └── hypridle.conf
│   ├── kitty/kitty.conf
│   ├── niri/config.kdl
│   └── nvim/init.vim
├── hosts/
│   ├── common.nix                # Locale, user, docker, home-manager
│   ├── wsl/default.nix
│   ├── laptop/
│   │   ├── default.nix           # AMD, battery, bluetooth, GUI
│   │   └── hardware.nix
│   └── vm-fusion/
│       ├── default.nix           # VMware guest tools, GUI
│       └── hardware.nix
├── modules/
│   ├── system/
│   │   ├── docker.nix            # Docker daemon
│   │   ├── nix-settings.nix      # Flakes, GC, mirrors
│   │   └── gui/
│   │       ├── niri.nix          # Niri compositor + SDDM
│   │       ├── audio.nix         # PipeWire
│   │       └── fonts.nix         # Nerd Fonts
│   └── user/
│       ├── default.nix           # CLI tools (ripgrep, fd, fzf, bat, eza, jq, ...)
│       ├── shell.nix             # Bash (minimal, for direnv integration)
│       ├── editors.nix           # Helix, Neovim, Vim (packages only)
│       ├── dev-tools.nix         # Node.js, Go, Python, Rust, C/C++, tokei, nmap, ...
│       ├── git.nix               # Git, delta, gh, git-lfs (packages only)
│       ├── direnv.nix            # direnv + nix-direnv
│       └── gui/
│           ├── niri.nix          # Noctalia shell, hyprlock, screenshot tools
│           ├── terminals.nix     # Alacritty, Kitty, Ghostty (packages only)
│           └── firefox.nix       # Firefox (Nix config)
```

## Pre-installed Packages

### Programming Languages
- **Node.js 22** + TypeScript + pnpm
- **Go** + gopls + golangci-lint + delve
- **Python 3.12** + pip + virtualenv + pyright + ruff
- **Rust** (via rustup)
- **C/C++** - gcc, cmake, clang-tools, gdb

### Editors
- **Helix** - config in `config/helix/`
- **Neovim** - config in `config/nvim/`
- **Vim**

### CLI Tools
ripgrep, fd, fzf, bat, eza, jq, yq, htop, btop, curl, wget, tldr, tokei, git-delta, gh

### Network / Security
openssl, nmap, netcat

### GUI (laptop and vm-fusion only)
- **Niri** - Wayland scrollable tiling compositor
- **Noctalia Shell** - desktop shell (panel, launcher, wallpaper)
- **SDDM** - display manager (sddm-astronaut-theme)
- **Hyprlock / Hypridle** - screen lock & idle management
- **Firefox** - web browser
- **Alacritty / Kitty / Ghostty** - terminal emulators
- **Mako** - notification daemon
- **PipeWire** - audio system

## Mirrors

China mirrors (SJTU, Tsinghua) for faster downloads in Southeast Asia:

1. `mirror.sjtu.edu.cn`
2. `mirrors.tuna.tsinghua.edu.cn`
3. `cache.nixos.org` (fallback)

## Notes

- Default user: `thangha`
- Timezone: `Asia/Ho_Chi_Minh`
- Databases: use Docker containers, not installed in NixOS
- `direnv` + `nix-direnv`: automatic per-project `flake.nix` devShell
