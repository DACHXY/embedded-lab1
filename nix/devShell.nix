{
  lib,
  mkShell,
  gcc,
  gmp,
  mpfr,
  libmpc,
  bison,
  git,
  isl,
}:
let
  rpathLibs = [
    gmp
    mpfr
    libmpc
    isl
  ];
in
mkShell {
  name = "lab1";

  packages = [
    gcc
    git
    gmp
    mpfr
    libmpc
    bison
    isl
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath rpathLibs;
  shellHook = ''
    unset CC CXX OBJCOPY
  '';
}
