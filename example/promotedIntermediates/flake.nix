{
  description = "Flake example of intermediates-nix";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    intermediates-nix.url = "github:erikeah/intermediates-nix";
  };

  outputs = inputs@{ flake-parts, intermediates-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
          packages = intermediates-nix.lib.withIntermediatesOnSet null {
              default = { requestedIntermediates, ... }: with pkgs; stdenv.mkDerivation {
                  name = "example";
                  description = "bla bla... bla";
                  dontUnpack = true;
                  dontConfigure = true;
                  outputs = [ "out" "intermediates" ];
                  buildPhase = ''
                    cp -r ${requestedIntermediates} $intermediates
                    find $intermediates -exec chmod u+w {} +
                    find $intermediates -exec touch -d '1970-01-01T00:00:00Z' {} +

                    date >> $intermediates/message
                  '';
                  installPhase = ''
                    mkdir $out/bin -p
                    echo -e '#!/bin/sh\ncat' "$intermediates/message" > $out/bin/intermediates-message
                    chmod 755 $out/bin/intermediates-message
                  '';
              };
          };
      };
    };
}
