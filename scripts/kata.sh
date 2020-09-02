#! /usr/bin/env bash

# stop script with non-zero exit code if anything go wrong
set -e

# stop script with non-zero exit code when trying to reference an undefined
# variable
set -u

# If any command in a pipeline fails, that return code will be used as the
# return code of the whole pipeline
set -o pipefail

SOURCES_DIR="${SOURCES_DIR:-$PWD}"
KATA_NAME="$(echo "${1// }" | tr "[:upper:]" "[:lower:]")"

KATAS_SOURCE_DIR="$SOURCES_DIR/katas"
KATAS_TESTS_DIR="$SOURCES_DIR/tests"

KATA_SOURCE_PY="$KATAS_SOURCE_DIR/${KATA_NAME}.py"
mkdir -p "$KATAS_SOURCE_DIR"
[ -f "$KATA_SOURCE_PY" ] || touch "$KATA_SOURCE_PY"

KATA_TESTS_PY="$KATAS_TESTS_DIR/test_${KATA_NAME}.py"
mkdir -p "$KATAS_TESTS_DIR"
[ -f "$KATA_TESTS_PY" ] || cat > "$KATA_TESTS_PY" <<EOF
import katas.${KATA_NAME}

def test_NAME():
    assert False
EOF