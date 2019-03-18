#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq - Sub7Seven
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Upgrade
apt-get update -y
# apt-get upgrade -y # causes problems when you forced on an interactive screen
apt-get install software-properties-common git zip unzip dialog -y
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  INSTALLING: PGBlitz Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
By Installing PGBlitz, you are agreeing to the terms and conditions
of the GNUv3 Project License! Please Standby...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
sleep 3

# Delete If it Exist for Cloning
file="/opt/pgblitz"
if [ -e "$file" ]; then rm -rf /opt/pgblitz; fi

file="/opt/pgstage"
if [ -e "$file" ]; then rm -rf /opt/pgstage; fi

rm -rf /opt/pgstage/place.holder 1>/dev/null 2>&1

git clone -b v8.6 --single-branch https://github.com/PGBlitz/Install.git /opt/pgstage

mkdir -p /opt/var/logs
echo "" > /opt/var/server.ports
echo "51" > /opt/var/pg.pythonstart
touch /opt/var/pg.pythonstart.stored
start=$(cat /opt/var/pg.pythonstart)
stored=$(cat /opt/var/pg.pythonstart.stored)

if [ "$start" != "$stored" ]; then
bash /opt/pgstage/pyansible.sh
fi
echo "51" > /opt/var/pg.pythonstart.stored

ansible-playbook /opt/pgstage/clone.yml
cp /opt/pgblitz/menu/alias/templates/pgblitz /bin/pgblitz
cp /opt/pgblitz/menu/alias/templates/pg /bin/pg
cp /opt/pgblitz/menu/alias/templates/plexguide /bin/plexguide
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Verifiying PGBlitz / PGBlitz Installed @ /bin/pgblitz - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 2

file="/bin/pgblitz"
if [ ! -e "$file" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! Installed Failed! PGBlitz / PGBlitz Command Missing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Please Reinstall PGBlitz by running the Command Again! We are doing
this to ensure that your installation continues to work!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
exit
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASSED! The PGBlitz / PGBlitz Command Installed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
rm -rf /opt/var/new.install 1>/dev/null 2>&1
sleep 2
chmod 775 /bin/pgblitz
chown 1000:1000 /bin/pgblitz
chmod 775 /bin/pgblitz
chown 1000:1000 /bin/pgblitz

## Other Folders
mkdir -p /opt/appdata/pgblitz
mkdir -p /opt/var

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Start AnyTime By Typing >>> pgblitz [or] pg
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
