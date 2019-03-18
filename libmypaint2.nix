{stdenv, glib, python27Full, pkgconfig, libtool, intltool, automake, autoconf, fetchFromGitHub, json_c}:

stdenv.mkDerivation rec {
    name = "libmypaint-2.0";
    src = fetchFromGitHub {
        owner = "mypaint";
        repo = "libmypaint";
        rev = "d180edddf425d08127fe63fe0d175786a0624e83";
        sha256 = "0mfivcb9h135x252gfh82qf2yywhys8w8b32am1vzpcdffdqrhgs";
    };
    nativeBuildInputs = [ autoconf automake intltool libtool pkgconfig python27Full ];
    buildInputs = [ glib ];
    propagatedBuildInputs = [ json_c ]; # for libmypaint.pc
    doCheck = true;
    preConfigure = "./autogen.sh";
}
