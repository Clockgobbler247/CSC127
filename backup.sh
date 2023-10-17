!/bin/bash
####################################
#
# Backup to /dev/sdc 75GB Backup Drive mounted to /backups
#
####################################
# What to backup. 
backup_files="/"

# Where to backup to.
dest="/backups/sys_backup"


# Create archive filename.
day=$(date +%A)

hostname=$(hostname -s)

archive_file="$hostname-$day.tgz"



# Print start status message.

echo "Backing up $backup_files to $dest/$archive_file"

date

echo

# Backup the files using tar.

#tar czf $dest/$archive_file $backup_files

sudo tar czfvp $dest/$archive_file --exclude=/dev/* --exclude=/proc/* --exclude=/backups/* --exclude=/home/*--exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" --exclude=".cache" --exclude="Downloads" --exclude=".VirtualBoxVMs"--exclude=".ecryptfs" $backup_files


# Print end status message.

echo

echo "Backup finished"

date

# Long listing of files in $dest to check file sizes.

ls -lh $dest

