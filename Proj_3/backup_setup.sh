####################################################################################
###########This script is used to create a file structure for Proj_3 backups########
####################################################################################

#Used to make directories for backups
sudo mkdir -p /backups/{sys_backup,usr_backup}/{full_backup,diff_backup}
sudo mkdir /backups/sys_backup/full_backup/{new,old}
sudo mkdir /backups/usr_backup/full_backup/{new,old}
