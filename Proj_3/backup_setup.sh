####################################################################################
###########This script is used to create a file structure for Proj_3 backups########
####################################################################################

#Used to make directories for backups
sudo mkdir -p /backups/{sys_backup,usr_backup}/{full_backup,diff_backup}
sudo mkdir /backups/sys_backup/full_backup/{new,old}
sudo mkdir /backups/usr_backup/full_backup/{new,old}


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
