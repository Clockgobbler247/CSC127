#!/bin/bash

# Define the line to check for in sudoers
desired_line="rootceo ALL=(ALL:ALL) ALL"

# Check if the line already exists in the sudoers file
if grep -qF "$desired_line" /etc/sudoers; then
  echo "The line is already present in /etc/sudoers."
else
  # Append the line directly to sudoers using tee and sudo
  if echo "$desired_line" | sudo tee -a /etc/sudoers > /dev/null; then
    echo "The line has been added to /etc/sudoers."
  else
    echo "Error: Failed to add the line to /etc/sudoers."
    exit 1
  fi
fi


  # Clean up the temporary file

  rm "$temp_file"

#fi

# Installs members, net-tools, vim, squid, and e2guardian
sudo apt update
sudo apt install -y members net-tools vim squid e2guardian sl 


# Sets the date and time
timedatectl set-timezone America/Chicago

#Create a File System on /dev/sdb
sudo mkfs.ext4 /dev/sdb

# Changing the mount point of /home to /dev/sdb
sudo mkdir /mnt/tmp
sudo mount /dev/sdb /mnt/tmp
sudo rsync -avx /home/* /mnt/tmp/
sudo umount /mnt/tmp
sudo mount /dev/sdb /home

#Remove the old /home files
#sudo umount /home
#sudo rm -rf /home/*

# Aquire the UUID for /dev/sdb
result=$(sudo blkid -o value -s UUID "/dev/sdb")

# Print the UUID to check if it's obtained correctly
echo "UUID: $result"

# Define the line to check for in fstab
desired_line1="UUID=$result  /home ext4  defaults  0 2"

# Check if the line already exists in the fstab file
if grep -Fxq "$desired_line1" /etc/fstab; then
  echo "The line is already present in /etc/fstab."
else
  # Add the line to fstab using echo and append (>>) operator
  echo "$desired_line1" | sudo tee -a /etc/fstab > /dev/null
  echo "The line has been added to /etc/fstab."
fi
