#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
SOURCE_DIR="${SCRIPT_DIR}/../../notopia/docs/src/public/diagrams"
TARGET_DIR="${SCRIPT_DIR}/../src/assets/sync-diagrams"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Remove all existing files in target directory
rm -f "$TARGET_DIR"/*

# Process and copy files
for file in "$SOURCE_DIR"/*.svg; do
	if [ -f "$file" ]; then
		basename=$(basename "$file")

		# Remove the first word (d2 or plantuml) and the dash
		# Then remove the hash and the dash before it
		# d2-architecture-diagram-df3208fc3327cf9cf1f49877af40f47a.svg -> architecture-diagram.svg
		# plantuml-class-diagram-note-d82ce413f7d221d63afffc90487dccd4.svg -> class-diagram-note.svg

		# Remove the prefix (d2- or plantuml-)
		temp="${basename#*-}"

		# Remove the hash suffix (-HASH.svg)
		# Keep everything up to the last dash followed by hex characters and .svg
		newname=$(echo "$temp" | sed 's/-[a-f0-9]\{32\}\.svg/.svg/')

		# Copy with new name
		cp "$file" "$TARGET_DIR/$newname"
		echo "Copied: $basename -> $newname"
	fi
done

echo "Sync complete. Files copied to $TARGET_DIR"
