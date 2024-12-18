{
    intermediates.url = "github:erikeah/intermediates-nix"
}:{
    packages.x86_64-linux.hello = intermediates.lib.callWithIntermediatesFrom "packages.x86_64-linux.hello" prevIntermediates: mkDerivation {
        name = "hello";
        ...
        buildPhase = ''
         cp $prevIntermediates $intermediates
        ''
    };
}
