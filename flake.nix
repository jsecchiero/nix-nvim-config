{
  description = "Neovim opinionated flake";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    "lazy.nvim" = {
      url = "github:folke/lazy.nvim";
      flake = false;
    };
    vim-fugitive = {
      url = "github:tpope/vim-fugitive";
      flake = false;
    };
    vim-rhubarb = {
      url = "github:tpope/vim-rhubarb";
      flake = false;
    };
    vim-sleuth = {
      url = "github:tpope/vim-sleuth";
      flake = false;
    };
    vim-surround = {
      url = "github:tpope/vim-surround";
      flake = false;
    };
    vim-obsession = {
      url = "github:tpope/vim-obsession";
      flake = false;
    };
    vim-prosession = {
      url = "github:dhruvasagar/vim-prosession";
      flake = false;
    };
    vim-tmux-navigator = {
      url = "github:christoomey/vim-tmux-navigator";
      flake = false;
    };
    better-vim-tmux-resizer = {
      url = "github:RyanMillerC/better-vim-tmux-resizer";
      flake = false;
    };
    "copilot.vim" = {
      url = "github:github/copilot.vim";
      flake = false;
    };
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    "fidget.nvim" = {
      url = "github:j-hui/fidget.nvim";
      flake = false;
    };
    "neodev.nvim" = {
      url = "github:folke/neodev.nvim";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    LuaSnip = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
    cmp_luasnip = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    friendly-snippets = {
      url = "github:rafamadriz/friendly-snippets";
      flake = false;
    };
    "which-key.nvim" = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    "gitsigns.nvim" = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    "gruvbox.nvim" = {
      url = "github:ellisonleao/gruvbox.nvim";
      flake = false;
    };
    "lualine.nvim" = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    "Comment.nvim" = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };
    "telescope.nvim" = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    "plenary.nvim" = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    "telescope-fzf-native.nvim" = {
      url = "github:nvim-telescope/telescope-fzf-native.nvim";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    nvim-treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, neovim, ... } @inputs: let

    appName = "nix-nvim";
    plugins = builtins.removeAttrs inputs ["self" "nixpkgs" "neovim"];
    loadPlugins = import ./plugins.nix {
      inherit pkgs;
      inherit plugins;
      inherit appName;
    };
    tools = import ./tools.nix {
      inherit pkgs;
    };
    loadConfig = import ./config.nix { inherit pkgs; inherit appName; };

    overlayMyNeovim = prev: final: {
      myNeovim = final.wrapNeovim final.neovim {
        configure = {
          customRC = ''
            ${pkgs.lib.concatStringsSep "\n" (map (pkg: "let $PATH=$PATH .. \"${pkg}/bin\"") tools.packages)}
            let $NVIM_APPNAME="${appName}"
            let config_root="${loadConfig.dir}/${appName}"
            let lazy_root="${loadPlugins.dir}/${appName}/lazy"
            luafile ${loadConfig.dir}/${appName}/init.lua
          '';
          packages.all.start = with pkgs.vimPlugins; [
            nvim-treesitter
          ];
        };
        withRuby = false;
        withPython3 = false;
        withNodeJs = false;
      };
    };

    overlayFlakeInputs = prev: final: {
      neovim = neovim.packages.x86_64-linux.neovim;
    };

    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ overlayFlakeInputs overlayMyNeovim ];
    };

  in {
    packages.x86_64-linux.default = pkgs.myNeovim;
  };
}
