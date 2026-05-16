#!/bin/bash

set -euo pipefail

missing=()
repo_install_failed=""

for cmd in curl git git-lfs make; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing+=("$cmd")
  fi
done

if ! command -v repo >/dev/null 2>&1; then
  mkdir -p "$HOME/bin"
  if curl -s https://storage.googleapis.com/git-repo-downloads/repo -o "$HOME/bin/repo"; then
    chmod +x "$HOME/bin/repo"
    export PATH="$HOME/bin:$PATH"
  else
    repo_install_failed="repo (auto install failed: https://storage.googleapis.com/git-repo-downloads/repo)"
  fi
fi

if ! command -v repo >/dev/null 2>&1; then
  missing+=("${repo_install_failed:-repo (install from https://storage.googleapis.com/git-repo-downloads/repo)}")
fi

if ! command -v java >/dev/null 2>&1; then
  missing+=("java (OpenJDK 17 recommended)")
fi

if ! command -v python3 >/dev/null 2>&1; then
  missing+=("python3")
fi

if [ ${#missing[@]} -ne 0 ]; then
  echo "Missing required tools:"
  for item in "${missing[@]}"; do
    echo "- ${item}"
  done
  exit 1
fi

echo "Preflight OK: required tools found."
