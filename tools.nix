{ pkgs }:
{
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
  ];
}
