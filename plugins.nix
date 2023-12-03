{ pkgs, plugins, appName }: let
  pluginsFiles = plugins: let
    pluginsDir = pkgs.stdenv.mkDerivation {
      name = "nvim-plugins";
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/${appName}/lazy
        ${builtins.concatStringsSep "\n" (pkgs.lib.mapAttrsToList (
          name: repo: "cp -r ${repo} $out/${appName}/lazy/${name}"
        ) plugins)}
      '';
    };
  in { 
    dir = "${pluginsDir}"; 
  };
in pluginsFiles plugins
