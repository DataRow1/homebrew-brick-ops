#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/update_formula.sh 0.1.5
# or:
#   ./scripts/update_formula.sh v0.1.5
#
# Assumes:
# - repo: https://github.com/DataRow1/brick-ops
# - formula: Formula/brick-ops.rb
# - release assets:
#     dbops-darwin-arm64.tar.gz
#     dbops-darwin-amd64.tar.gz

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version> (e.g. 0.1.5 or v0.1.5)" >&2
  exit 2
fi

TAG="$VERSION"
if [[ "$TAG" != v* ]]; then
  TAG="v$TAG"
fi
VER_NO_V="${TAG#v}"

OWNER="DataRow1"
REPO="brick-ops"
BASE="https://github.com/${OWNER}/${REPO}/releases/download/${TAG}"

ARM_ASSET="dbops-darwin-arm64.tar.gz"
AMD_ASSET="dbops-darwin-amd64.tar.gz"

FORMULA_PATH="Formula/brick-ops.rb"
if [[ ! -f "$FORMULA_PATH" ]]; then
  echo "Formula not found at: $FORMULA_PATH" >&2
  exit 2
fi

tmpdir="$(mktemp -d)"
cleanup() { rm -rf "$tmpdir"; }
trap cleanup EXIT

fetch_and_sha() {
  local url="$1"
  local out="$2"
  echo "Downloading: $url"
  curl -fsSL "$url" -o "$out"
  shasum -a 256 "$out" | awk '{print $1}'
}

ARM_SHA="$(fetch_and_sha "${BASE}/${ARM_ASSET}" "${tmpdir}/${ARM_ASSET}")"
AMD_SHA="$(fetch_and_sha "${BASE}/${AMD_ASSET}" "${tmpdir}/${AMD_ASSET}")"

echo "arm64 sha256: $ARM_SHA"
echo "amd64 sha256: $AMD_SHA"

# Update version line: version "x.y.z"
perl -0777 -i -pe "s/version\\s+\\\"[0-9.]+\\\"/version \\\"${VER_NO_V}\\\"/g" "$FORMULA_PATH"

# Update URLs (keep your formula structure intact)
perl -0777 -i -pe "s|releases/download/v[0-9.]+/dbops-darwin-arm64\\.tar\\.gz|releases/download/${TAG}/dbops-darwin-arm64.tar.gz|g" "$FORMULA_PATH"
perl -0777 -i -pe "s|releases/download/v[0-9.]+/dbops-darwin-amd64\\.tar\\.gz|releases/download/${TAG}/dbops-darwin-amd64.tar.gz|g" "$FORMULA_PATH"

# Update sha256 lines (assumes exactly two sha256 entries in the macOS on_macos block)
# We match by nearby URL to avoid swapping them.
perl -0777 -i -pe "s|(dbops-darwin-arm64\\.tar\\.gz\\\"\\s*\\n\\s*sha256\\s+\\\")[a-f0-9]{64}(\\\")|\\1${ARM_SHA}\\2|g" "$FORMULA_PATH"
perl -0777 -i -pe "s|(dbops-darwin-amd64\\.tar\\.gz\\\"\\s*\\n\\s*sha256\\s+\\\")[a-f0-9]{64}(\\\")|\\1${AMD_SHA}\\2|g" "$FORMULA_PATH"

echo
echo "Updated: $FORMULA_PATH"
echo "Now run:"
echo "  git diff"
echo "  git commit -am \"brick-ops ${VER_NO_V}\""
echo "  git push"
