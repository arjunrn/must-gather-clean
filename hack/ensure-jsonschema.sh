#!/bin/bash
set -euo pipefail

VERSION=0.9.0
GOOS=$(go env GOOS)
case "$GOOS" in
    linux)
    CHECKSUM="3b25ae15c0dc6b379ff1750620c0af9b294d7539f3f73041f4928f795b7ecf6a"
    ;;
    darwin)
    CHECKSUM="de1447545cd4de7714e10611dc0ba7548ed7b9ec1921be4266a487d5c8f8002a"
    ;;
    *)
    echo "Unknown OS: $GOOS"
    exit 1
    ;;
esac

LOCATION_URL=https://github.com/atombender/go-jsonschema/releases/download/v${VERSION}/gojsonschema-${GOOS}-amd64
DESTINATION=bin/gojsonschema

mkdir -p bin
if [ -f "$DESTINATION" ]; then
    if echo "$CHECKSUM $DESTINATION" | sha256sum --check --quiet ;then
        echo "Cached version is up-to-date. Exiting."
        exit
    else
        echo "Checksums do not match. Downloading again."
        rm -f $DESTINATION
    fi
fi

curl -s -L -o "$DESTINATION" "$LOCATION_URL"
chmod +x "$DESTINATION"

if echo "$CHECKSUM $DESTINATION" | sha256sum --check --quiet ;then
    echo "Downloaded and verified successfully"
else
    echo "Checksum of downloaded executable is incorrect."
    exit 1
fi