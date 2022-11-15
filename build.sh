#!/bin/bash

TOPS="circt"

build() {
  echo "Building $1..."
  nix-build $1.nix --no-out-link
  STOREPATH=$(nix-build ./$1.nix)
  DRVPATH=$(nix-instantiate ./$1.nix)
  echo "Copying to cache: $DRVPATH, $STOREPATH"
  # nix store sign --recursive -k ../cache-priv-key.pem $STOREPATH
  # nix store sign --recursive -k ../cache-priv-key.pem $DRVPATH
  nix copy --derivation --to "s3://nix?profile=nix-upload&scheme=https&endpoint=minio.inner.fi.c-3.moe&secret-key=../cache-priv-key.pem" $DRVPATH
  nix copy --to "s3://nix?profile=nix-upload&scheme=https&endpoint=minio.inner.fi.c-3.moe&secret-key=../cache-priv-key.pem" $STOREPATH
}

for TOP in $TOPS; do
  build $TOP
done
