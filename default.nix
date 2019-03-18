let
    pkgs = import <nixpkgs> {};
    libmypaint2 = pkgs.stdenv.mkDerivation {
        name = "libmypaint-2.0";
        src = pkgs.fetchFromGitHub {
          owner = "mypaint";
          repo = "libmypaint";
          rev = "d180edddf425d08127fe63fe0d175786a0624e83";
          sha256 = "0mfivcb9h135x252gfh82qf2yywhys8w8b32am1vzpcdffdqrhgs";
        };
        nativeBuildInputs = [ pkgs.autoconf pkgs.automake pkgs.intltool pkgs.libtool pkgs.pkgconfig pkgs.python27Full ];
        buildInputs = [ pkgs.glib ];
        propagatedBuildInputs = [ pkgs.json_c ]; # for libmypaint.pc
                doCheck = true;
        preConfigure = "./autogen.sh";
    };
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
