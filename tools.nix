{ pkgs, naersk }: let

  naersk-lib = pkgs.callPackage naersk { };

  gdshader = naersk-lib.buildPackage {
    src = pkgs.fetchFromGitHub {
      owner = "GodOfAvacyn";
      repo = "gdshader-lsp";
      rev = "main";
      sha256 = "sha256-kzZhHIRXW3m3n5TlNRDQO9XsDoSi59N7+4NeFKtauEM=";
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
    pkgs.jsonnet-language-server
    pkgs.typescript
    pkgs.nodePackages.typescript-language-server
    gdshader
  ];
}
