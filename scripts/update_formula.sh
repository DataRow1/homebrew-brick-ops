#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/update_formula.sh 0.1.3
#
# Assumptions:
# - GitHub repo: https://github.com/DataRow1/db-ops
# - Homebrew tap contains: Formula/brick-ops.rb
# - Release assets:
#     dbops-darwin-arm64.tar.gz
#     dbops-darwin-amd64.tar.gz

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version> (e.g. 0.1.3)" >&2
  exit 2
fi

OWNER="DataRow1"
REPO="db-ops"
TAG="$VERSION"
BASE="https://github.com/${OWNER}/${REPO}/releases/download/${TAG}"

ARM_ASSET="dbops-darwin-arm64.tar.gz"
AMD_ASSET="dbops-darwin-amd64.tar.gz"
LINUX_ARM_ASSET="dbops-linux-arm64.tar.gz"
LINUX_AMD_ASSET="dbops-linux-amd64.tar.gz"

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

  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$out" | awk '{print $1}'
  else
    shasum -a 256 "$out" | awk '{print $1}'
  fi
}

ARM_SHA="$(fetch_and_sha "${BASE}/${ARM_ASSET}" "${tmpdir}/${ARM_ASSET}")"
AMD_SHA="$(fetch_and_sha "${BASE}/${AMD_ASSET}" "${tmpdir}/${AMD_ASSET}")"
LINUX_AMD_SHA="$(fetch_and_sha "${BASE}/${LINUX_AMD_ASSET}" "${tmpdir}/${LINUX_AMD_ASSET}")"

echo
echo "Computed SHA256:"
echo "  arm64 : $ARM_SHA"
echo "  amd64 : $AMD_SHA"
echo

# 1) Update version line
perl -0777 -i -pe "s/version\\s+\\\"[0-9.]+\\\"/version \\\"${VERSION}\\\"/g" "$FORMULA_PATH"

# 2) Update URLs
perl -0777 -i -pe "s|releases/download/[0-9.]+/dbops-darwin-arm64\\.tar\\.gz|releases/download/${TAG}/dbops-darwin-arm64.tar.gz|g" "$FORMULA_PATH"
perl -0777 -i -pe "s|releases/download/[0-9.]+/dbops-darwin-amd64\\.tar\\.gz|releases/download/${TAG}/dbops-darwin-amd64.tar.gz|g" "$FORMULA_PATH"
perl -0777 -i -pe "s|releases/download/[0-9.]+/dbops-linux-amd64\\.tar\\.gz|releases/download/${TAG}/dbops-linux-amd64.tar.gz|g" "$FORMULA_PATH"

# 3) Update sha256 values (bound to the correct asset)
perl -0777 -i -pe "s|(dbops-darwin-arm64\\.tar\\.gz\\\"\\s*\\n\\s*sha256\\s+\\\")[a-f0-9]{64}(\\\")|\\1${ARM_SHA}\\2|g" "$FORMULA_PATH"
perl -0777 -i -pe "s|(dbops-darwin-amd64\\.tar\\.gz\\\"\\s*\\n\\s*sha256\\s+\\\")[a-f0-9]{64}(\\\")|\\1${AMD_SHA}\\2|g" "$FORMULA_PATH"
perl -0777 -i -pe "s|(dbops-linux-amd64\\.tar\\.gz\\\"\\s*\\n\\s*sha256\\s+\\\")[a-f0-9]{64}(\\\")|\\1${LINUX_AMD_SHA}\\2|g" "$FORMULA_PATH"

echo "✅ Updated $FORMULA_PATH"
echo
echo "Next steps:"
echo "  git diff"
echo "  git commit -am \"brick-ops ${VERSION}\""
echo "  git push"
