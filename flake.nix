{
  description = "Neovim opinionated flake";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    "lazy.nvim" = {
      url = "github:folke/lazy.nvim";
      flake = false;
    };
    "mini.files" = {
      url = "github:echasnovski/mini.files";
      flake = false;
    };
    "mini.icons" = {
      url = "github:echasnovski/mini.icons";
      flake = false;
    };
    "mini.surround" = {
      url = "github:echasnovski/mini.surround";
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
    "codeium.vim" = {
      url = "github:Exafunction/codeium.vim";
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
    nvim-treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects";
      flake = false;
    };
    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    naersk = {
      url = "github:nix-community/naersk/master";
    };
  };
  outputs = { self, nixpkgs, neovim, ... } @inputs: let

    appName = "nix-nvim";
    plugins = builtins.removeAttrs inputs ["self" "nixpkgs" "neovim" "naersk"];

    supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    myNeovimFor = system: let

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      loadPlugins = import ./plugins.nix {
        inherit pkgs;
        inherit plugins;
        inherit appName;
      };
      tools = import ./tools.nix {
        inherit pkgs;
        naersk = inputs.naersk;
      };
      loadConfig = import ./config.nix { inherit pkgs; inherit appName; };
      treeSitter = import ./treesitter { inherit pkgs; };

      myNeovim = pkgs.wrapNeovim neovim.packages.${system}.neovim {
        configure = {
          customRC = ''
            ${pkgs.lib.concatStringsSep "\n" (map (pkg: "let $PATH=$PATH .. \":${pkg}/bin\"") tools.packages)}
            let $NVIM_APPNAME="${appName}"
            let config_root="${loadConfig.dir}/${appName}"
            let lazy_root="${loadPlugins.dir}/${appName}/lazy"
            let treesitter_parsers_root="${treeSitter.parsersDir}"
            let treesitter_root="${treeSitter.dir}"
            let gdb_path="${pkgs.gdb}/bin/gdb"
            let codeium_path="${pkgs.codeium}/bin/codeium_language_server"
            luafile ${loadConfig.dir}/${appName}/init.lua
          '';
        };
        withRuby = false;
        withPython3 = false;
        withNodeJs = false;
      };
    in myNeovim;
  in {
    defaultPackage = forAllSystems (system: myNeovimFor system);
  };
}
