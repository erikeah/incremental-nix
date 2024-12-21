{
  description = "intermediates-hooks";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:
    {
      packages =
        builtins.mapAttrs
          (
            system: _:
            let
              pkgs = nixpkgs.legacyPackages.${system};
            in
            {
              intermediatesHook = pkgs.makeSetupHook {
                name = "intermediates-hook";
              } ./intermediates-hook.sh;
            }
          )
          {
            "x86_64-linux" = { };
            "aarch64-linux" = { };
            "aarch64-darwin" = { };
            "x86_64-darwin" = { };
          };
    };
}
