#!/usr/bin/env bash

set -e

declare cwd="$PWD"

package_dot_json="$cwd/package.json"

[[ ! -f "$package_dot_json" ]] && exit

SCRIPTS=($(jq '.scripts' "$package_dot_json" | jq -r 'keys | @sh' | sed "s/'//g"))

mapfile -t SCRIPTS < \
  <(LC_COLLATE=C sort < <(printf "%s\n" "${SCRIPTS[@]}"))

if [[ -n $COMP_LINE ]]; then
  line=${COMP_LINE#* }

  for s in "${SCRIPTS[@]}"; do
    [[ ${s:0:${#line}} == "${line,,}" ]] && echo "$s"
  done
  exit
fi

npm run "$@"
