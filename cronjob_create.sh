#!/bin/bash

# make script delete itself after running for cleanup
function delete_script { rm -f -- "$0"; }

trap delete_script EXIT

# script file path including script name & filetype ( likely .sh), this is the script that the cronjob will run 
script_path=

#create script to be run
sudo cat > ${script_path} << EOL
#!/bin/bash
# put commands you want here
EOL

# make script executeable
sudo chmod +x ${script_path}


# create root crontab if it doesn't exist
if ! test -e /etc/crontab;
then
sudo touch /etc/crontab
fi

# create root cronjob that runs every minute (modify if wanting different time schedule)
sudo crontab -l | { cat; echo "* * * * * ${script_path}"; } | sudo crontab -

