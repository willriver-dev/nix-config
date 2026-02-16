# NixOS Multi-Host Configuration

Cau hinh NixOS dung Nix Flakes cho nhieu may, phuc vu backend development.

## Cac host

| Host | Kien truc | Mo ta |
|------|-----------|-------|
| `wsl` | x86_64-linux | Windows Subsystem for Linux (headless) |
| `laptop` | x86_64-linux | ThinkPad E14 Gen 7 AMD (Niri + GUI) |
| `vm-fusion` | aarch64-linux | VMware Fusion tren macOS M1 (Niri + GUI) |

## Cai dat

### Buoc 1: Cai NixOS

- **WSL**: Tai NixOS-WSL tu [nix-community/NixOS-WSL](https://github.com/nix-community/NixOS-WSL)
- **Laptop/VM**: Cai NixOS tu ISO, chon cai dat toi thieu (minimal)

### Buoc 2: Clone repo

```bash
git clone <repo-url> ~/workspace/nixos-config
cd ~/workspace/nixos-config
```

### Buoc 3: Cau hinh cho tung may

#### Thay thong tin Git ca nhan

Sua file `modules/user/git.nix`:

```nix
userName = "Ten cua ban";
userEmail = "email@cua-ban.com";
```

#### Thay hardware config (chi cho laptop va vm-fusion)

Chay lenh sau tren may thuc te de lay cau hinh phan cung:

```bash
sudo nixos-generate-config --show-hardware-config > ~/hardware.nix
```

Sau do copy noi dung vao:
- Laptop: `hosts/laptop/hardware.nix`
- VM Fusion: `hosts/vm-fusion/hardware.nix`

### Buoc 4: Build va ap dung

```bash
# Cho WSL
sudo nixos-rebuild switch --flake ~/workspace/nixos-config#wsl

# Cho Laptop (ThinkPad E14 Gen 7 AMD)
sudo nixos-rebuild switch --flake ~/workspace/nixos-config#laptop

# Cho VM Fusion (macOS M1)
sudo nixos-rebuild switch --flake ~/workspace/nixos-config#vm-fusion
```

### Buoc 5: Sau khi build lan dau

Setup Rust toolchain (rustup duoc cai san, can khoi tao):

```bash
rustup default stable
rustup component add rust-analyzer
```

## Cac lenh tat (aliases)

Sau khi build thanh cong, ban co the dung cac alias sau:

| Alias | Lenh |
|-------|------|
| `rebuild` | `sudo nixos-rebuild switch --flake ...#<host>` |
| `update` | `nix flake update` - cap nhat tat ca flake inputs |
| `ll` | `eza -la` - liet ke file chi tiet |
| `ls` | `eza` - liet ke file |
| `cat` | `bat` - xem file co syntax highlight |
| `tree` | `eza --tree` - cay thu muc |
| `dps` | `docker ps` - xem container dang chay |
| `dco` | `docker compose` |

## Cap nhat he thong

```bash
# Cap nhat tat ca flake inputs (nixpkgs, home-manager, niri, ...)
update

# Ap dung thay doi
rebuild
```

Hoac thu cong:

```bash
nix flake update --flake ~/workspace/nixos-config
sudo nixos-rebuild switch --flake ~/workspace/nixos-config#<host>
```

## Cau truc thu muc

```
nixos-config/
├── flake.nix                     # Diem vao: dinh nghia inputs va 3 host
├── hosts/
│   ├── common.nix                # Cau hinh chung (locale, user, docker, nix)
│   ├── wsl/default.nix           # Chi rieng cho WSL
│   ├── laptop/
│   │   ├── default.nix           # ThinkPad: AMD, pin, bluetooth, GUI
│   │   └── hardware.nix          # Phan cung (can thay bang nixos-generate-config)
│   └── vm-fusion/
│       ├── default.nix           # VM: VMware guest tools, GUI
│       └── hardware.nix          # Phan cung (can thay bang nixos-generate-config)
├── modules/
│   ├── system/
│   │   ├── docker.nix            # Docker daemon
│   │   ├── nix-settings.nix      # Flakes, GC, mirror Trung Quoc
│   │   └── gui/                  # Chi cho host co GUI
│   │       ├── niri.nix          # Niri compositor + greetd
│   │       ├── audio.nix         # PipeWire
│   │       └── fonts.nix         # Nerd Fonts
│   └── user/
│       ├── default.nix           # Cong cu CLI co ban
│       ├── shell.nix             # Bash + aliases
│       ├── editors.nix           # Helix, Neovim, Vim
│       ├── dev-tools.nix         # Node.js, Go, Python, Rust, C/C++
│       ├── git.nix               # Git + delta + GitHub CLI
│       ├── direnv.nix            # direnv cho per-project devShell
│       └── gui/                  # Chi cho host co GUI
│           ├── niri.nix          # Phim tat, layout, waybar
│           ├── terminals.nix     # Alacritty, Kitty, Ghostty
│           └── firefox.nix       # Firefox
```

## Cong cu da cai san

### Ngon ngu lap trinh
- **Node.js 22** + TypeScript + pnpm
- **Go** + gopls + golangci-lint + delve
- **Python 3.12** + pip + virtualenv + pyright + ruff
- **Rust** (via rustup) - can chay `rustup default stable` lan dau
- **C/C++** - gcc, cmake, clang-tools (clangd), gdb

### Editor
- **Helix** (editor mac dinh, `$EDITOR=hx`) - da cau hinh LSP cho tat ca ngon ngu
- **Neovim** - cau hinh co ban
- **Vim** - cai dat goi

### CLI tools
ripgrep, fd, fzf, bat, eza, jq, yq, htop, btop, curl, wget, tldr, git-delta, gh (GitHub CLI)

### GUI (chi laptop va vm-fusion)
- **Niri** - Wayland tiling compositor
- **Firefox** - trinh duyet
- **Alacritty / Kitty / Ghostty** - terminal emulator
- **Fuzzel** - app launcher (Mod+D)
- **Waybar** - thanh trang thai
- **PipeWire** - am thanh

## Phim tat Niri (chi host GUI)

| Phim | Chuc nang |
|------|-----------|
| `Mod+Return` | Mo terminal (Alacritty) |
| `Mod+D` | Mo app launcher (Fuzzel) |
| `Mod+Q` | Dong cua so |
| `Mod+F` | Phong to cot |
| `Mod+Shift+F` | Fullscreen |
| `Mod+H/J/K/L` | Di chuyen focus |
| `Mod+Shift+H/J/K/L` | Di chuyen cua so |
| `Mod+1-5` | Chuyen workspace |
| `Mod+Shift+1-5` | Chuyen cua so sang workspace |
| `Print` | Chup man hinh |

## Mirror

Config su dung mirror Trung Quoc (SJTU, Tsinghua) de tang toc do download cho khu vuc Dong Nam A. Thu tu uu tien:

1. `mirror.sjtu.edu.cn` - Shanghai Jiao Tong University
2. `mirrors.tuna.tsinghua.edu.cn` - Tsinghua University
3. `cache.nixos.org` - Mirror chinh thuc (du phong)

## Ghi chu

- User mac dinh: `thangha`
- Timezone: `Asia/Ho_Chi_Minh`
- Database khong cai trong NixOS - su dung Docker container
- `direnv` + `nix-direnv` ho tro per-project `flake.nix` devShell tu dong
# nix-config
