#!/usr/bin/env bash
# Regenerates all *.pb.go files under proto/ from their *.proto sources.
#
# Requires:
#   protoc         v3.21.12 (https://github.com/protocolbuffers/protobuf/releases/tag/v21.12)
#   protoc-gen-go  v1.36.10 (go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.10)
#
# Usage (from repo root or from proto/):
#   ./proto/generate.sh
#
# protoc-gen-go must be on $PATH (e.g. $(go env GOPATH)/bin).
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v protoc >/dev/null 2>&1; then
	echo "error: protoc not found on PATH (expected v3.21.12)" >&2
	exit 1
fi

if ! command -v protoc-gen-go >/dev/null 2>&1; then
	echo "error: protoc-gen-go not found on PATH (expected v1.36.10; go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.10)" >&2
	exit 1
fi

echo "Using: $(protoc --version)"
echo "Using: $(protoc-gen-go --version)"

mapfile -t proto_files < <(find . -name '*.proto' | sort)

protoc --go_out=paths=source_relative:. -I. "${proto_files[@]}"

echo "Regenerated ${#proto_files[@]} proto files."
