#!/bin/bash

TOPS="circt"

build() {
  echo "Building $1..."
  nix-build $1.nix -o $1.out
  REALPATH=$(readlink -f $1.out)
  echo "Copying to cache: $REALPATH"
  nix copy --to "s3://nix?profile=nix-upload&scheme=https&endpoint=minio.inner.fi.c-3.moe" $REALPATH
}

for TOP in $TOPS; do
  build $TOP
done
