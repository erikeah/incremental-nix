{
  description = "Flake example of intermediates-nix";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    intermediates-nix.url = "github:erikeah/intermediates-nix";
    intermediates-nix-hook.url = "github:erikeah/intermediates-nix?dir=hook";
    promotedIntermediates.url = "path:./promotedIntermediates";
  };

  outputs =
    inputs@{ flake-parts, intermediates-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          packages = intermediates-nix.lib.withIntermediatesOnSet inputs'.promotedIntermediates.packages {
            default =
              { requestedIntermediates, ... }:
              with pkgs;
              stdenv.mkDerivation {
                name = "example";
                description = "bla bla... bla";
                dontUnpack = true;
                dontConfigure = true;
                env = { inherit requestedIntermediates; };
                outputs = [
                  "out"
                  "intermediates"
                ];
                nativeBuildInputs = [ inputs'.intermediates-nix-hook.packages.intermediatesHook ];
                buildPhase = ''
                  runHook preBuild

                  date >> $intermediates/message

                  runHook postBuild
                '';
                installPhase = ''
                  runHook preInstall

                  mkdir $out/bin -p
                  echo -e '#!/bin/sh\ncat' "$intermediates/message" > $out/bin/intermediates-message
                  chmod 755 $out/bin/intermediates-message

                  runHook postInstall
                '';
              };
          };
        };
    };
}
