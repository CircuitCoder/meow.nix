{ pkgs ? import ./pinned-nixpkgs.nix {}}:
pkgs.pkgsCross.riscv64-embedded.stdenv.mkDerivation rec {
  pname = "riscv-tests";
  version = "e9ab2e9502894692302d289a950a08cf2c25db68";
  src = pkgs.fetchgit {
    url = "https://github.com/riscv-software-src/riscv-tests.git";
    rev = "${version}";
    fetchSubmodules = true;
    sha256 = "sha256-/1PoXOs/XTWNx+zSHN7Ldl1SvR1nJ753Gs+WUcuoPtE=";
  };

  enableParallelBuilding = true;

  buildPhase = "make RISCV_PREFIX=riscv64-none-elf-";
}
