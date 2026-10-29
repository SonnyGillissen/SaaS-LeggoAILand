#!/bin/sh
# Assembles a ready-to-upload folder in ./dist using the latest prebuilt
# Emscripten (WebAssembly) build of isle-portable.
set -eu
cd "$(dirname "$0")"

REPO=isledecomp/isle-portable
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "Downloading WebAssembly build..."
curl -fsSL -o "$TMP/em.tar.gz" \
  "https://github.com/$REPO/releases/download/continuous/isle-0.1-Emscripten-emscripten.tar.gz"
tar -xzf "$TMP/em.tar.gz" -C "$TMP"

rm -rf dist
mkdir -p dist/LEGO
cp "$TMP"/*/bin/isle.js "$TMP"/*/bin/isle.wasm dist/
cp index.html coi-sw.js .htaccess nginx.conf.example README.md dist/
cp LEGO/README.txt dist/LEGO/

echo "Done. Upload the contents of ./dist to your web root, then add your LEGO Island files to LEGO/."
