{
  mkShell,
  gcc12_3_0,
  binutils2_40,
  glibc2_38,
  git,
  linux,
}:
mkShell {
  name = "lab1";

  buildInputs = [
    gcc12_3_0
    binutils2_40
    glibc2_38
    linux
    git
  ];
}
