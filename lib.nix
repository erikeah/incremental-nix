{ ... }:
let
  almostEmpty = ./almostEmptyDir;
in
{
  callWithIntermediatesFrom =
    package: callback:
    let
      requestedIntermediates =
        if builtins.isAttrs package && package.intermediates != null then
          package.intermediates
        else
          almostEmpty;

    in
    callback {
        inherit requestedIntermediates;
    };
  # TODO: callWithIntermediates = callback: {};
}
