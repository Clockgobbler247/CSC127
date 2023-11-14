#!/bin/bash
####################################################################################
########################### Project #4 - NFS shares ################################
####################################################################################

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Format sdd
mkfs.ext4 /dev/sdd

# Mount /shares to sdd
mkdir -p /shares/{collab,research}
mount /dev/sdd /shares
chmod -R 777 /shares


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

## Create Directories for backups
sudo mkdir -p /backups/shares/{collab,research}/{full_backup,diff_backup}
sudo mkdir /backups/shares/collab/full_backup/{new,old}
sudo mkdir /backups/shares/research/full_backup/{new,old}


## Update the VM and install Samba
apt update -y
apt install -y samba expect

# List of usernames and corresponding passwords
user_credentials=(
    "theceo:root"
    "thecio:root"
    "thecfo:root"
    "salesmgr:root"
    "researchmgr:root"
    "rootceo:root"
    "ashlee:root"
)

# Loop through the usernames and passwords and create each user
for user_cred in "${user_credentials[@]}"; do
    username=$(echo "$user_cred" | cut -d':' -f1)
    password=$(echo "$user_cred" | cut -d':' -f2)

    # Use expect to interact with smbpasswd and provide the password
    expect -c "
        spawn sudo smbpasswd -a $username
        expect \"New SMB password:\"
        send \"$password\r\"
        expect \"Retype new SMB password:\"
        send \"$password\r\"
        interact
    "
done

# Restart System Services
sudo systemctl start smbd && sudo systemctl start nmbd
sudo systemctl enable smbd nmbd
