#!/bin/bash

set -euo pipefail

missing=()

for cmd in curl git git-lfs make; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing+=("$cmd")
  fi
done

if ! command -v repo >/dev/null 2>&1; then
  missing+=("repo (install from https://storage.googleapis.com/git-repo-downloads/repo)")
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
