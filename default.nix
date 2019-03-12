let
    pkgs = import <nixpkgs> {};
    libmypaint2 = pkgs.stdenv.lib.overrideDerivation pkgs.libmypaint (oldAttr: {
        name = "libmypaint-2.0";
        patches = [];
        src = pkgs.fetchFromGitHub {
          owner = "mypaint";
          repo = "libmypaint";
          rev = "v2.0.0-alpha.1";
          sha256 = "0mfivcb9h135x252gfh82qf2yywhys8w8b32am1vzpcdffdqrhgs";
        };
    });
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
