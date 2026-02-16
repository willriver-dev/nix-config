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

#### Update personal Git information

Edit the file `modules/user/git.nix`:

```nix
userName = "Your Name";
userEmail = "your@email.com";
```

#### Replace hardware config (laptop and vm-fusion only)

Run the following command on the actual machine to get hardware configuration:

```bash
sudo nixos-generate-config --show-hardware-config > ~/hardware.nix
```

Then copy the content to:
- Laptop: `hosts/laptop/hardware.nix`
- VM Fusion: `hosts/vm-fusion/hardware.nix`

### Step 4: Build and apply

**Note: All commands below should be run from the `nixos` directory (not the repository root).**

```bash
# For WSL
cd ~/workspace/nixos-config/nixos
sudo nixos-rebuild switch --flake .#wsl

# For Laptop (ThinkPad E14 Gen 7 AMD)
cd ~/workspace/nixos-config/nixos
sudo nixos-rebuild switch --flake .#laptop

# For VM Fusion (macOS M1)
cd ~/workspace/nixos-config/nixos
sudo nixos-rebuild switch --flake .#vm-fusion
```

### Step 5: After first build

Setup Rust toolchain (rustup is pre-installed, needs initialization):

```bash
rustup default stable
rustup component add rust-analyzer
```

## Shell Aliases

After successful build, you can use the following aliases:

| Alias | Command |
|-------|---------|
| `rebuild` | `sudo nixos-rebuild switch --flake ...#<host>` |
| `update` | `nix flake update` - update all flake inputs |
| `ll` | `eza -la` - detailed file listing |
| `ls` | `eza` - list files |
| `cat` | `bat` - view files with syntax highlighting |
| `tree` | `eza --tree` - directory tree |
| `dps` | `docker ps` - view running containers |
| `dco` | `docker compose` |

## System Updates

**Note: Run these commands from the `nixos` directory.**

```bash
# Update all flake inputs (nixpkgs, home-manager, niri, ...)
cd ~/workspace/nixos-config/nixos
update

# Apply changes
rebuild
```

Or manually:

```bash
cd ~/workspace/nixos-config/nixos
nix flake update
sudo nixos-rebuild switch --flake .#<host>
```

## Directory Structure

```
nixos-config/
├── flake.nix                     # Entry point: defines inputs and 3 hosts
├── hosts/
│   ├── common.nix                # Common configuration (locale, user, docker, nix)
│   ├── wsl/default.nix           # WSL-specific configuration
│   ├── laptop/
│   │   ├── default.nix           # ThinkPad: AMD, battery, bluetooth, GUI
│   │   └── hardware.nix          # Hardware config (replace with nixos-generate-config)
│   └── vm-fusion/
│       ├── default.nix           # VM: VMware guest tools, GUI
│       └── hardware.nix          # Hardware config (replace with nixos-generate-config)
├── modules/
│   ├── system/
│   │   ├── docker.nix            # Docker daemon
│   │   ├── nix-settings.nix      # Flakes, GC, China mirrors
│   │   └── gui/                  # GUI-enabled hosts only
│   │       ├── niri.nix          # Niri compositor + greetd
│   │       ├── audio.nix         # PipeWire
│   │       └── fonts.nix         # Nerd Fonts
│   └── user/
│       ├── default.nix           # Basic CLI tools
│       ├── shell.nix             # Bash + aliases
│       ├── editors.nix           # Helix, Neovim, Vim
│       ├── dev-tools.nix         # Node.js, Go, Python, Rust, C/C++
│       ├── git.nix               # Git + delta + GitHub CLI
│       ├── direnv.nix            # direnv for per-project devShell
│       └── gui/                  # GUI-enabled hosts only
│           ├── niri.nix          # Keybindings, layout, waybar
│           ├── terminals.nix     # Alacritty, Kitty, Ghostty
│           └── firefox.nix       # Firefox
```

## Pre-installed Tools

### Programming Languages
- **Node.js 22** + TypeScript + pnpm
- **Go** + gopls + golangci-lint + delve
- **Python 3.12** + pip + virtualenv + pyright + ruff
- **Rust** (via rustup) - run `rustup default stable` after first boot
- **C/C++** - gcc, cmake, clang-tools (clangd), gdb

### Editors
- **Helix** (default editor, `$EDITOR=hx`) - LSP configured for all languages
- **Neovim** - basic configuration
- **Vim** - package installation

### CLI Tools
ripgrep, fd, fzf, bat, eza, jq, yq, htop, btop, curl, wget, tldr, git-delta, gh (GitHub CLI)

### GUI (laptop and vm-fusion only)
- **Niri** - Wayland scrollable tiling compositor
- **Waybar** - status bar and system tray
- **Firefox** - web browser
- **Alacritty / Kitty / Ghostty** - terminal emulators
- **Mako** - notification daemon
- **PipeWire** - audio system

## Niri Keybindings (GUI hosts only)

| Key | Function |
|-----|----------|
| `Mod+Return` | Open terminal (Alacritty) |
| `Mod+Q` | Close window |
| `Mod+F` | Maximize column |
| `Mod+Shift+F` | Fullscreen |
| `Mod+H/J/K/L` | Move focus (left/down/up/right) |
| `Mod+Shift+H/J/K/L` | Move window (left/down/up/right) |
| `Mod+1-5` | Switch to workspace |
| `Mod+Shift+1-5` | Move window to workspace |
| `Print` | Take screenshot |

## Mirrors

Configuration uses China mirrors (SJTU, Tsinghua) to speed up downloads for Southeast Asia region. Priority order:

1. `mirror.sjtu.edu.cn` - Shanghai Jiao Tong University
2. `mirrors.tuna.tsinghua.edu.cn` - Tsinghua University
3. `cache.nixos.org` - Official mirror (fallback)

## Notes

- Default user: `thangha`
- Timezone: `Asia/Ho_Chi_Minh`
- Databases are not installed in NixOS - use Docker containers instead
- `direnv` + `nix-direnv` support automatic per-project `flake.nix` devShell
