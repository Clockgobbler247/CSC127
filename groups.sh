#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Define the text file containing usernames and groups
GROUPLIST="/etc/scripts/CSC171/groupnames.txt"

# Loop through the usernames and groups in the file
while IFS=: read -r username groups; do
  # Remove carriage return and newline characters from the input
  username=$(echo "$username" | tr -d "\r\n")
  groups=$(echo "$groups" | tr -d "\r\n")

  # Check if the user exists
  if id "$username" &>/dev/null; then
    # Loop through the groups separated by commas
    IFS=',' read -ra group_array <<< "$groups"
    for group in "${group_array[@]}"; do
      # Remove carriage return and newline characters from the group name
      group=$(echo "$group" | tr -d "\r\n")

      # Check if the group exists
      if grep -q "^$group:" /etc/group; then
        # Add the user to the existing group
        usermod -aG "$group" "$username"
        echo "User '$username' added to group: $group"
      else
        # Create the group and add the user to it
        groupadd "$group"
        usermod -aG "$group" "$username"
        echo "User '$username' added to new group: $group"
      fi
    done
  else
    echo "User '$username' does not exist. Skipping."
  fi
done < "$GROUPLIST"

echo "User group assignment completed."

#Add directories and permissions
mkdir /home/HumanResources
mkdir /home/Incorporation
mkdir /home/Policy
mkdir /home/Collab

chown -G hr /home/HumanResources
chmod 700 /home/HumanResources
chown  -G execs /home/Incorporation
chmod 700 /home/Incorporation
chown -G policy /home/Policy
chmod 700 /home/Policy
chown -G allstaff /home/Collab
chmod 700 /home/Collab
