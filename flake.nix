{
  description = "Lab 1";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-gcc =
        # gcc 12.3.0
        import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/c407032be28ca2236f45c49cfb2b8b3885294f7f.tar.gz";
          sha256 = "07gzgcgaclgand7j99w45r07gc464b5jbpaa3wmv6nzwzdb3v3q4";
        }) { inherit system; };
      # binutils 2.40
      pkgs-binutils = (
        import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3.tar.gz";
          sha256 = "0v8vnmgw7cifsp5irib1wkc0bpxzqcarlv8mdybk6dck5m7p10lr";
        }) { inherit system; }
      );
      # glibc 2.38
      pkgs-glibc = (
        import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/67b4bf1df4ae54d6866d78ccbd1ac7e8a8db8b73.tar.gz";
          sha256 = "1q2fn8szx99narznglglsdpc6c4fj1mhrl42ig02abjqfikl723i";
        }) { inherit system; }
      );
      gcc12_3_0 = pkgs-gcc.gcc;
      binutils2_40 = pkgs-binutils.binutils;
      glibc2_38 = pkgs-glibc.glibc;
    in
    {
      devShells.${system}.default = pkgs.callPackage ./nix/devShell.nix {
        inherit gcc12_3_0 binutils2_40 glibc2_38;
      };
    };
}
