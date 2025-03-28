{
  gcc,
  gmp,
  mpfr,
  libmpc,
  bison,
  glibc,
  binutils,
  git,
  texinfo,
  isl,
  stdenv,
  buildFHSEnv,
  dejagnu,
  autogen,
  flex,
  m4,
  zlib,
  xz,
  libxcrypt,
  libffi,
  ncurses5,
  qemu-user,
  expat,
}:
let
  fhsEnv = buildFHSEnv {
    name = "lab1-gcc";
    targetPkgs =
      ps: with ps; [
        gmp
        gmp.dev
        isl
        libmpc
        mpfr
        mpfr.dev
        libffi
        libffi.dev
        libxcrypt
        bison
        xz
        xz.dev
        zlib
        zlib.dev
        m4
        bison
        flex
        texinfo
        gcc
        stdenv.cc
        stdenv.cc.libc
        stdenv.cc.libc_dev
        git
        dejagnu
        autogen
        binutils
        glibc
        glibc.dev
        ncurses5
        ncurses5.dev
        qemu-user
        expat
        expat.dev
      ];

    profile =
      # bash
      '''';
  };
in
fhsEnv.env
