#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Define the text file containing usernames and groups
GROUPLIST="/etc/scripts/groups.txt"

# Loop through the usernames and groups in the file
while IFS=: read -r username groups; do
  # Check if the user exists
  if id "$username" &>/dev/null; then
    # Add the user to the specified groups
    usermod -aG "$groups" "$username"
    echo "User '$username' added to group(s): $groups"
  else
    echo "User '$username' does not exist. Skipping."
  fi
done < "$GROUPLIST"

echo "User group assignment completed."
