#!/bin/bash
####################################################################################
########################### Project #4 - NFS shares ################################
####################################################################################

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Change hostname of VM
rm -rf /etc/hostname
touch /etc/hostname

# Check if the line already exists in the /etc/hostname file
if grep -Fxq "Team-A2" /etc/hostname; then
  echo "The line is already present in /etc/hostname."
else
  # Add the line to /etc/hostname using echo and append (>>) operator
  echo "Team-A2" | sudo tee -a /etc/hostname > /dev/null
  echo "Hostname has been changed."
fi

# Format sdd
mkfs.ext4 /dev/sdd

# Mount /shares to sdd
mkdir /shares
mount /dev/sdd /shares
chmod 777 /shares


# Aquire the UUID for /dev/sdd
result=$(sudo blkid -o value -s UUID "/dev/sdd")

# Print the UUID to check if it's obtained correctly
echo "UUID: $result"

# Define the line to check for in fstab
desired_line1="UUID=$result  /shares ext4  defaults  0 2"

# Check if the line already exists in the fstab file
if grep -Fxq "$desired_line1" /etc/fstab; then
  echo "The line is already present in /etc/fstab."
else
  # Add the line to fstab using echo and append (>>) operator
  echo "$desired_line1" | sudo tee -a /etc/fstab > /dev/null
  echo "The line has been added to /etc/fstab."
fi


## Update the VM and install Samba
apt update -y
apt install -y samba
