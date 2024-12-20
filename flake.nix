{
  description = "Simple library to work with intermediates";
  inputs = { };
  outputs = inputs: {
    lib = import ./lib.nix { };
  };
}
