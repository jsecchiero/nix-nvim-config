{ pkgs }: let
  parsers = import ./parsers.nix;
  builtGrammarsFiltered = pkgs.lib.filterAttrs (
    name: _: builtins.elem name parsers
  ) pkgs.vimPlugins.nvim-treesitter.builtGrammars;
  parsersFiles = let
    parsersDir = pkgs.stdenv.mkDerivation {
      name = "nvim-treesitter-parsers";
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/parser
        ${builtins.concatStringsSep "\n" (pkgs.lib.mapAttrsToList (
          name: drv: "ln -s ${drv.outPath}/parser $out/parser/${name}.so"
        ) builtGrammarsFiltered)}
      '';
    };
  in { 
    parsersDir = "${parsersDir}";
    parsers = parsers;
    dir = pkgs.vimPlugins.nvim-treesitter.outPath;
  };
in parsersFiles
