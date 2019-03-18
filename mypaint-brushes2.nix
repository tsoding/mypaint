{fetchpatch, json_c, pkgconfig, automake, autoconf, fetchFromGitHub, stdenv}:

stdenv.mkDerivation rec {
  name = "mypaint-brushes-2.0";
  src = fetchFromGitHub {
    owner = "mypaint";
    repo = "mypaint-brushes";
    rev = "8b7a6435a40e52d12b8f3054312c1b728fc4f5ae";
    sha256 = "1iz89z6v2mp8j1lrf942k561s8311i3s34ap36wh4rybb2lq15m0";
  };
  nativeBuildInputs = [ autoconf automake pkgconfig ];
  propagatedBuildInputs = [ json_c ]; # for libmypaint.pc
  preConfigure = "./autogen.sh";
  doCheck = true;
  patches = [
    # build with automake 1.16
    (fetchpatch {
      url = https://github.com/Jehan/mypaint-brushes/commit/1e9109dde3bffd416ed351c3f30ecd6ffd0ca2cd.patch;
      sha256 = "0mi8rwbirl0ib22f2hz7kdlgi4hw8s3ab29b003dsshdyzn5iha9";
    })
  ];
}
