#!/bin/bash


# Define the line to check for in sudoers
desired_line="ashlee ALL=(ALL:ALL) ALL"

# Check if the line already exists in the sudoers file
if grep -Fxq "$desired_line" /etc/sudoers; then
  echo "The line is already present in /etc/sudoers."
else
  # Add the line to sudoers using visudo
  if visudo -c -q; then
    echo "$desired_line" | sudo EDITOR="tee -a" visudo
    echo "The line has been added to /etc/sudoers."
  else
    echo "Error: The line you provided is not valid for /etc/sudoers."
    exit 1
  fi
fi

# Installs vim
sudo apt install -y vim

# Sets the date and time
timedatectl set-timezone America/Chicago

#Create a File System on /dev/sdb
sudo mkfs.ext4 /dev/sdb

# Changing the mount point of /home to /dev/sdb
sudo mkdir /mnt/tmp
sudo mount /dev/sdb /mnt/tmp
sudo rsync -avx /home/* /mnt/tmp
sudo mount /dev/sdb /home

#Remove the old /home files
sudo umount /home
sudo rm -rf /home/*

# Aquire the UUID for /dev/sdb
result=$(sudo blkid -o value -s UUID "/dev/sdb")

# Define the line to check for in fstab
desired_line1="UUID=$result  /home ext4  defaults  0 2"

# Check if the line already exists in the fstab file
if grep -Fxq "$desired_line1" /etc/fstab; then
  echo "The line is already present in /etc/fstab."
else
  # Add the line to fstab using visudo
  if visudo -c -q; then
    echo "$desired_line1" | sudo EDITOR="tee -a" visudo
    echo "The line has been added to /etc/fstab."
  else
    echo "Error: The line you provided is not valid for /etc/fstab."
    exit 1
  fi
fi
