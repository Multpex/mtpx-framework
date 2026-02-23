#!/usr/bin/env bash

set -euo pipefail

SETUP_REPO_URL="https://github.com/Multpex/mtpx-framework-setup.git"
TMP_DIR="$(mktemp -d)"
SETUP_DIR="$TMP_DIR/mtpx-framework-setup"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "[multpex-framework] Clonando setup oficial..."
if ! git clone --depth 1 --quiet "$SETUP_REPO_URL" "$SETUP_DIR"; then
  echo "[multpex-framework] Falha ao clonar $SETUP_REPO_URL" >&2
  exit 1
fi

if [[ ! -x "$SETUP_DIR/install.sh" ]]; then
  chmod +x "$SETUP_DIR/install.sh"
fi

echo "[multpex-framework] Executando install.sh do mtpx-framework-setup..."
exec "$SETUP_DIR/install.sh" "$@"
