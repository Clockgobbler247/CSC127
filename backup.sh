#!/bin/bash
####################################
#
# Backup to /dev/sdc 75GB Backup Drive mounted to /backups
#
####################################

# Aquire the UUID for /dev/sdc
result=$(sudo blkid -o value -s UUID "/dev/sdc")

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


# What to backup. 

backup_files="/"

# Where to backup to

dest="/backups/sys_backup/full_backup/new"


# Create archive filename

day=$(date +%m_%d_%Y)


hostname=$(hostname -s)


archive_file="$hostname-$day"


# Print variable values for debugging

echo "dest: $dest"


echo "archive_file: $archive_file"




#Create Directory for backup
sudo mkdir $dest/$archive_file


# Print start status message.

echo "Backing up $backup_files to $dest/$archive_file"

date

echo

# Backup the files using tar.
#tar czf $dest/$archive_file $backup_files

sudo rsync -aAXHv --delete --exclude=/etc/scripts/* --exclude=/dev/* --exclude=/proc/* --exclude=/backups/* --exclude=/home/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" --exclude=".cache" --exclude="Downloads" --exclude=".VirtualBoxVMs" --exclude=".ecryptfs" $backup_files $dest/$archive_file

echo

echo "Backup finished"

date

# Long listing of files in $dest to check file sizes.

ls -lh $dest
