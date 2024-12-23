#  {#sec-functions-library-main}


## `lib.main.withIntermediates` {#function-library-lib.main.withIntermediates}

call a function giving the intermediates in context

#### Example:

```
packages.myPackage = withIntermediates prev.myPackage {}: stdenv.mkDerivation { ... };
```

#### Type

```
withIntermediates :: Set ->  Function -> (Set | Path)
```

## `lib.main.withIntermediatesOnSet` {#function-library-lib.main.withIntermediatesOnSet}

based on the attibutes of `set` finds in `pkgSet` for packages with
same name and containing intermediates

#### Example:

```
packages = withIntermediatesOnSet prev.packages {
    ...
}
    ;
```

#### Type

```
withIntermediatesOnSet :: Set -> Set -> Set
```


