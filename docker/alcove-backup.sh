#!/bin/sh

# Makes it so that the script will immediately exit if a command fails
set -e

# Variables
PUBLIC_KEY_PATH="/root/.ssh/id_rsa.pub"
AUTHORIZED_KEYS_FILE="/root/.ssh/authorized_keys"

# Check if the public key file exists
if [ ! -f "$PUBLIC_KEY_PATH" ]; then
  echo "Error: Public key file not found: $PUBLIC_KEY_PATH"
  exit 1
fi

# Check if the authorized keys file exists
if [ -f "$AUTHORIZED_KEYS_FILE" ]; then
  echo "Key is already authorized."

else

  # Ensure the .ssh directory exists
  mkdir -p "$(dirname "$AUTHORIZED_KEYS_FILE")"
  chmod 700 "$(dirname "$AUTHORIZED_KEYS_FILE")"

  # Copy the public key to the authorized keys file
  cp "$PUBLIC_KEY_PATH" "$AUTHORIZED_KEYS_FILE"
  chmod 600 "$AUTHORIZED_KEYS_FILE"

  echo "Key authorized successfully."

fi
