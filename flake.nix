{
  description = "Intermediates made easy?";
  inputs = { };
  outputs = inputs: {
      lib = import ./lib.nix {};
  };
}
