let
    pkgs = import <nixpkgs> {};
    libmypaint2 = pkgs.callPackage ./libmypaint2.nix {};
in rec {
    mypaintEnv = pkgs.stdenv.mkDerivation {
        name = "mypaint-env";
        buildInputs = [ pkgs.stdenv
                        pkgs.pkgconfig
                        pkgs.gcc
                        pkgs.gtk3
                        pkgs.lcms2
                        libmypaint2
                        pkgs.mypaint-brushes
                        pkgs.swig
                        pkgs.python27Full
                        pkgs.python27Packages.setuptools
                        pkgs.python27Packages.pygobject3
                        pkgs.python27Packages.numpy
                        pkgs.python27Packages.pycairo
                      ];
    };
}
