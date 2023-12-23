{ pkgs }:
{
  packages = [
    # Basic
    pkgs.git
    pkgs.nodejs_21
    pkgs.ripgrep
    pkgs.fd
    pkgs.fzf
    # Lsp servers
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.nodePackages.bash-language-server
    pkgs.clang-tools
    pkgs.pyright
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.gopls
    pkgs.terraform-ls
    pkgs.tflint
    pkgs.nixd
  ];
}
