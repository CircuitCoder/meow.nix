{ pkgs ? import ./pinned-nixpkgs.nix {}}:
pkgs.stdenv.mkDerivation rec {
  pname = "spike";
  version = "ab3225a3ff687fda8b4180f9e4e0949a400d1247";
  src = pkgs.fetchFromGitHub {
    owner = "riscv-software-src";
    repo = "riscv-isa-sim";
    rev = "${version}";
    sha256 = "sha256-2cC2goTmxWnkTm3Tq08R8YkkuI2Fj8fRvpEPVZ5JvUI=";
  };

  enableParallelBuilding = true;

  buildInputs = [
    pkgs.dtc
  ];

  configureFlags = [];
}
