{ pkgs ? import <nixpkgs> {}}:
let
  llvm = import ./llvm-mlir.nix { pkgs = pkgs; };
in
  pkgs.stdenv.mkDerivation rec {
    pname = "circt";
    version = "sifive/1/22/1";
    src = pkgs.fetchFromGitHub {
      owner = "llvm";
      repo = "${pname}";
      rev = "${version}";
      sha256 = "sha256-PPG53lmbHdvkrTDZG+JY2TBIadzJOF9E2jqGlu9mxeI=";
    };

    buildInputs = [
      llvm
      pkgs.cmake
      pkgs.python3
      pkgs.lit # Because somehow LLVM refuses to install llvm-lit
      pkgs.ninja
    ];

    cmakeFlags = [
      "-DMLIR_DIR=${llvm}/lib/cmake/mlir"
      "-DLLVM_DIR=${llvm}/lib/cmake/llvm"
      "-DLLVM_EXTERNAL_LIT=${pkgs.lit}/bin/lit"
      "-DLLVM_BUILD_LLVM_DYLIB=ON"
      "-DLLVM_LINK_LLVM_DYLIB=ON"
      "-DCMAKE_BUILD_TYPE=Release"
      "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
    ];
  }
