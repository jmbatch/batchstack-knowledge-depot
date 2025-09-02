# User Management Basics

```bash
# create a new user
sudo adduser dwight

# delete a user
sudo deluser dwight

# modify a users details
sudo usermod -d <new_home_dir> dwight

# lock a users account
sudo passwd -u dwight

# unlock a users account
sudo passwd -u dwight

# check user groups
groups dwight

# add a user to a group
sudo usermod -aG <group> dwight

# remove a user from a group
sudo gpasswd -d dwight <group>

# set or reset a users password
sudo passwd dwight
```
