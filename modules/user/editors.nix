{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "onedark";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp.display-messages = true;
        file-picker.hidden = false;
        indent-guides.render = true;
        soft-wrap.enable = true;
      };
    };

    languages = {
      language-server = {
        typescript-language-server = {
          command = "typescript-language-server";
          args = [ "--stdio" ];
        };
        gopls.command = "gopls";
        rust-analyzer.command = "rust-analyzer";
        pyright = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
        };
        nil.command = "nil";
        clangd.command = "clangd";
      };

      language = [
        { name = "nix"; language-servers = [ "nil" ]; auto-format = true; }
        { name = "go"; language-servers = [ "gopls" ]; auto-format = true; }
        { name = "rust"; language-servers = [ "rust-analyzer" ]; auto-format = true; }
        { name = "typescript"; language-servers = [ "typescript-language-server" ]; auto-format = true; }
        { name = "javascript"; language-servers = [ "typescript-language-server" ]; auto-format = true; }
        { name = "python"; language-servers = [ "pyright" ]; auto-format = true; }
        { name = "c"; language-servers = [ "clangd" ]; auto-format = true; }
        { name = "cpp"; language-servers = [ "clangd" ]; auto-format = true; }
      ];
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = false;
    defaultEditor = false;

    extraConfig = ''
      set number relativenumber
      set expandtab shiftwidth=2 tabstop=2
      set clipboard=unnamedplus
      set ignorecase smartcase
      set termguicolors
    '';
  };

  home.packages = with pkgs; [
    vim
  ];
}
