{ pkgs ? import ./pinned-nixpkgs.nix {}}:
pkgs.stdenv.mkDerivation rec {
  pname = "llvm-mlir";
  version = "53c251bd05704a3f76f660c3b715bf3f35e7d594";
  src = pkgs.fetchFromGitHub {
    owner = "llvm";
    repo = "llvm-project";
    rev = "53c251bd05704a3f76f660c3b715bf3f35e7d594";
    sha256 = "sha256-dOQ3INE3f6HY4Cr0gxTBLOnTE5FMtShUmZoIXHo1rtQ=";
  };
  sourceRoot = "source/llvm";

  buildInputs = [
    pkgs.cmake
    pkgs.python3
    pkgs.git
    pkgs.ninja
  ];

  cmakeFlags = [
    "-DLLVM_ENABLE_PROJECTS=mlir"
    "-DLLVM_TARGETS_TO_BUILD=host"
    "-DLLVM_ENABLE_ASSERTIONS=ON"
    "-DLLVM_INSTALL_UTILS=ON"
    "-DLLVM_BUILD_LLVM_DYLIB=ON"
    "-DLLVM_LINK_LLVM_DYLIB=ON"
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
