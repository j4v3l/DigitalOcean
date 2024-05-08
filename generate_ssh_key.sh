#!/bin/bash

# Set the SSH key file path
SSH_KEY="$HOME/.ssh/id_ed25519"
SSH_CONFIG="$HOME/.ssh/config"

# Check if the SSH key already exists
if [ -f "$SSH_KEY" ]; then
  echo "SSH key already exists: $SSH_KEY"
else
  # Create the SSH key
  echo "Generating new SSH key..."
  ssh-keygen -t ed25519 -f "$SSH_KEY" -N ""

  echo "SSH key generated: $SSH_KEY"
fi

# Display the public key
echo "Your public SSH key:"
cat "$SSH_KEY.pub"

# Check if the SSH config file exists
if [ -f "$SSH_CONFIG" ]; then
  echo "SSH config file already exists: $SSH_CONFIG"
else
  # Create a blank SSH config file
  echo "Creating blank SSH config file..."
  touch "$SSH_CONFIG"

  echo "SSH config file created: $SSH_CONFIG"
fi
