{
  mkShell,
  gcc12_3_0,
  binutils2_40,
  glibc2_38,
  git,
}:
mkShell {
  name = "lab1";

  packages = [
    gcc12_3_0
    binutils2_40
    glibc2_38
    git
  ];
}
