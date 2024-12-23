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
  /**
    call a function giving the intermediates in context

    ## Example:

    ```
    packages.myPackage = withIntermediates prev.myPackage {}: stdenv.mkDerivation { ... };
    ```

    ## Type

    ```
    withIntermediates :: Set ->  Function -> (Set | Path)
    ```
  */
  withIntermediates =
    pkg: expr:
    expr {
      requestedIntermediates = getRequestedIntermediates pkg;
    };

  /**
    based on the attibutes of `set` finds in `pkgSet` for packages with
    same name and containing intermediates

    ## Example:

    ```
    packages = withIntermediatesOnSet prev.packages {
        ...
    }
        ;
    ```

    ## Type

    ```
    withIntermediatesOnSet :: Set -> Set -> Set
    ```
  */
  withIntermediatesOnSet =
    pkgSet: set:
    if builtins.isAttrs pkgSet then
      builtins.mapAttrs (key: expr: withIntermediates pkgSet.${key} expr) set
    else
      builtins.mapAttrs (key: expr: withIntermediates null expr) set;

}
