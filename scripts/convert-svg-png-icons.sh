#!/bin/bash

# Script to convert SVG icon files to PNG icon files.
#
# Prerequisite:
#   - rsvg-convert  (install by: sudo apt install librsvs-bin)
#
# Usage:
#   ./convert-svg-png-icons.sh icons/

# Check if the user provided a directory
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/directory"
  exit 1
fi

# Get the directory from the first argument
DIR="$1"

# Check if the directory exists
if [ ! -d "$DIR" ]; then
  echo "Error: Directory $DIR does not exist."
  exit 1
fi

# Function to convert SVG to PNG
convert_svg_to_png() {
  local svg_file="$1"
  local png_file="${svg_file%.svg}.png"

  echo "Converting $svg_file to $png_file"
  # Output PNG image of size 24x24
  rsvg-convert -o "$png_file" "$svg_file" -w 24 -h 24
}

# Export the function so it can be used by 'find' command
export -f convert_svg_to_png

# Find all SVG files in the directory and convert them
find "$DIR" -type f -name "*.svg" -exec bash -c 'convert_svg_to_png "$0"' {} \;

echo "Conversion complete."
