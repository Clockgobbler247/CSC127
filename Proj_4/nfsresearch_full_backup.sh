# What to backup. 

backup_files="/shares/research/*"

# Where to backup to

dest="/backups/shares/research/full_backups/new"


# Create archive filename

hostname=$(hostname -s)

archive_file="$hostname-nfsresearch_share_full_backup"

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
#rsync $dest/$archive_file $backup_files
sudo rsync -aAXHv --delete --exclude=.cache/* --exclude=tmp/* $backup_files $dest/$archive_file

echo

echo "Backup finished"

date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
