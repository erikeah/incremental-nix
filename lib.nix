{ ... }:
let
  almostEmpty = ./almostEmptyDir;
in
rec {
  getRequestedIntermediates =
    package:
    if builtins.isAttrs package && package.intermediates != null then
      package.intermediates
    else
      almostEmpty;
  withIntermediates =
    pkg: expr:
    expr {
      requestedIntermediates = getRequestedIntermediates pkg;
    };
  withIntermediatesOnSet =
    pkgSet: set:
    if builtins.isAttrs pkgSet then
      builtins.mapAttrs (key: expr: withIntermediates pkgSet.${key} expr) set
    else
      builtins.mapAttrs (key: expr: withIntermediates null expr) set;

}
