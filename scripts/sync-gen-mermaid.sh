#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
ROOT_DIR="${SCRIPT_DIR}/../src/assets/diagrams/"

find "$ROOT_DIR" -type f -name "*.mmd" | while read -r file; do
	svg="${file%.mmd}.svg"
	hash_file="${file}.hash"

	current_hash=$(sha256sum "$file" | awk '{print $1}')

	if [[ -f "$hash_file" ]]; then
		previous_hash=$(cat "$hash_file")
	else
		previous_hash=""
	fi

	if [[ "$current_hash" == "$previous_hash" ]]; then
		echo "⏭️  Skipping unchanged: $file"
		continue
	fi

	echo "🔄 Generating: $svg"
	mmdc -i "$file" -o "$svg"

	echo "$current_hash" >"$hash_file"
done
