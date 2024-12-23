# intermediates-nix

This library helps to import cache or other assets making use of
intermediates.

Files to be used lately can be saved on `intermediates`, which is just a regular output of a package like the default
`out`. Take a look to this [example](./example/flake.nix) if you wish.

[Documentation](./docs) or `nixdoc --file lib.nix --category "main" --description "" > docs/index.md`
