#!/usr/bin/env bash

set -e

declare cwd="$PWD"
declare package_dot_json="$cwd/package.json"

[[ ! -f "$package_dot_json" ]] && exit

SCRIPTS=($(jq '.scripts' "$package_dot_json" | jq -r 'keys | @sh' | sed "s/'//g"))

mapfile -t SCRIPTS < \
  <(LC_COLLATE=C sort < <(printf "%s\n" "${SCRIPTS[@]}"))

if [[ -n $COMP_LINE ]]; then
  line=${COMP_LINE#* }

  for s in "${SCRIPTS[@]}"; do
    arg="${s:0:${#line}}"
    line="${line,,}"

    if [[ $arg == "$line" ]]; then

      # process sub commands (command:subcommand:subcommand)
      if [[ $line =~ ":" ]]; then
        s=${line##*:}${s#$line*}
        [[ $s == "${line##*:}" ]] && continue
      fi

      echo "$s"
    fi

  done
  exit
fi

if [[ -f "$cwd/package-lock.json" ]]; then
  npm run "$@"
elif [[ -f "$cwd/yarn.lock" ]]; then
  yarn "$@"
fi
