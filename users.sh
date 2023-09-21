#!/bin/bash
# This script creates users from a given file

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

# Read the input file
user_file="/etc/scripts/usernames.txt"

# Check if the input file exists
if [ ! -f "$user_file" ]; then
  echo "Usernames file not found: $user_file"
  exit 1
fi

# Specify the custom shell and home directory base path
custom_shell="/bin/bash"
home_base="/home/"

# Create the home base directory if it doesn't exist
if [ ! -d "$home_base" ]; then
  mkdir "$home_base"
fi

# Generate a random password and assign it to the user
random_password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
echo "Assigning password as $random_password"

# Create the users
while IFS= read -r username; do
  # Check if the user already exists
  if id "$username" >/dev/null 2>&1; then
    echo "User $username already exists"
  else
    # Set the custom home directory for the user
    custom_home="${home_base}/${username}"
    
    # Create the user with a custom shell, home directory, and comment
    useradd -m -d "$custom_home" -s "$custom_shell" -c "$username" "$username"
    echo "User $username created with custom shell and home directory"
    
    echo "$username:$random_password" | chpasswd
    echo "Assigned random password to user $username: $random_password"

    # Force the user to change the password at the first login
    chage -d 0 "$username"
    echo "User $username is required to change the password at the first login"
  fi
done <"$user_file"

echo "User creation process completed"
