#!/usr/bin/env bash

set -euo pipefail

function changed.files {
  git diff --cached --name-only |
    grep \
      -e '\.bash_profile$' \
      -e '\.bashrc$' \
      -e '\.sh$' \
      -e '\.zsh$' \
      -e '\.zshrc$' || true
}

declare -a files=()

while read -r file; do
  files[${#files[@]} + 1]=$file
done < <(changed.files)

if ! [[ ${#files[@]} -eq 0 ]]; then
  shellcheck "${files[@]}"
fi
