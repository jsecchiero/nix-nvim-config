{ pkgs, naersk }: let

  naersk-lib = pkgs.callPackage naersk { };

  gdshader = naersk-lib.buildPackage {
    src = pkgs.fetchFromGitHub {
      owner = "GodOfAvacyn";
      repo = "gdshader-lsp";
      rev = "b290b6793498ba1795b869a58a18eda2d22b8f3a";
      sha256 = "sha256-TcL5o7mBxoTOL+QWbH+467nnzzDB8ev0BeLIw/h7FQQ=";
    };
  };

in {
  packages = [
    # Basic
    pkgs.git
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.fd
    pkgs.fzf
    # Lsp servers
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.nodePackages.bash-language-server
    pkgs.clang-tools
    pkgs.pyright
    pkgs.vscode-langservers-extracted
    pkgs.gopls
    pkgs.terraform-ls
    pkgs.tflint
    pkgs.nixd
    pkgs.zls
    pkgs.ols
    pkgs.jsonnet-language-server
    pkgs.typescript
    pkgs.nodePackages.typescript-language-server
    gdshader
  ];
}
