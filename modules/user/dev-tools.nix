{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Node.js / TypeScript
    nodejs_22
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.pnpm

    # Go
    go
    gopls
    golangci-lint
    delve

    # Python
    python312
    python312Packages.pip
    python312Packages.virtualenv
    pyright
    ruff

    # Rust (via rustup - run `rustup default stable` after first boot)
    rustup

    # C/C++ build tools
    gcc
    gnumake
    cmake
    pkg-config
    gdb
    clang-tools

    # Nix tooling
    nil
    nixpkgs-fmt

    # General build/debug
    gnused
    gawk
    binutils
    file
    strace

    # Code analysis
    tokei

    # Network/security
    openssl
    nmap
    netcat-gnu
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
    GOBIN = "$HOME/go/bin";
    CARGO_HOME = "$HOME/.cargo";
    RUSTUP_HOME = "$HOME/.rustup";
  };

  home.sessionPath = [
    "$HOME/go/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];
}
