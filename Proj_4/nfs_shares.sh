#!/bin/bash
####################################################################################
########################### Project #4 - NFS shares ################################
####################################################################################

# Format newly added disk
sudo mkfs.ext4 /dev/sdd

# Aquire the UUID for /dev/sdd
result=$(sudo blkid -o value -s UUID "/dev/sdd")

# Print the UUID to check if it's obtained correctly
echo "UUID: $result"

# Define the line to check for in fstab
desired_line1="UUID=$result  /backups ext4  defaults  0 2"

# Check if the line already exists in the fstab file
if grep -Fxq "$desired_line1" /etc/fstab; then
  echo "The line is already present in /etc/fstab."
else
  # Add the line to fstab using echo and append (>>) operator
  echo "$desired_line1" | sudo tee -a /etc/fstab > /dev/null
  echo "The line has been added to /etc/fstab."
fi


## Update the VM and install Samba
sudo apt update -y && sudo apt install -y samba
