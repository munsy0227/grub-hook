#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi

# Define the paths
SCRIPT_DIR=$(dirname "$(realpath "$0")")
HOOK_SOURCE="$SCRIPT_DIR/99-grub.hook"
HOOKS_DIR="/etc/pacman.d/hooks"
HOOK_DEST="$HOOKS_DIR/99-grub.hook"

# Create the hooks directory if it doesn't exist
if [ ! -d "$HOOKS_DIR" ]; then
  mkdir -p "$HOOKS_DIR"
fi

# Copy the hook file to the destination
if [ -f "$HOOK_SOURCE" ]; then
  cp "$HOOK_SOURCE" "$HOOK_DEST"
  echo "99-grub.hook has been successfully installed to $HOOK_DEST."
else
  echo "Error: 99-grub.hook not found in the script directory ($SCRIPT_DIR)."
  exit 1
fi
