{ pkgs, appName }: let
  configFiles = dir: let
    configDir = pkgs.stdenv.mkDerivation {
      name = "nvim-${dir}-configs";
      src = ./${dir};
      installPhase = ''
        mkdir -p $out/${appName}/
        cp -r ./* $out/${appName}/
      '';
    };
  in { 
    dir = "${configDir}";
  };

in configFiles "config"
