#!/usr/bin/env python3
# This is a little helper utility to create users and add the correct ssh keys on the required location

import json
import os
import sys


if len(sys.argv) != 2:
    exit("Usage: {} <config>".format(sys.argv[0]))


if os.geteuid() != 0:
    exit("You need to have root privileges to run this script.")


CONFIG_FILE = sys.argv[1]
if not os.path.isfile(CONFIG_FILE):
    exit(f"ERROR: Config file \"{CONFIG_FILE}\" not found!")


try:
    with open(CONFIG_FILE) as fh:
        config_data = json.loads(fh.read())
except Exception:
    exit(f"ERROR: Config file \"{CONFIG_FILE}\" cannot be read!")


# {
#   "username": "flip",
#    "fullname": "Flip Hess",
#    "shell": "/bin/bash",
#    "ssh_keys": [
#      {
#        "comment": "flip@zaaksysteem.nl",
#        "key": "AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJ0aRXmlCO+dBCfmakY9KXMUk5s2zQdlQ5d7vILlG4mhe4R8+hokIIa+m0KG9D1epG2TeWu8343pONl58NZXBCM=",
#        "type": "ecdsa-sha2-nistp256"
#      }
#    ]
#  }

for user in config_data:
    username = user.get('username')
    fullname = user.get('fullname')
    ssh_keys = user.get('ssh_keys')
    shell = user.get('shell')

    ## Create user account
    print(f"Creating user account for {username}")
    os.system(f"useradd --create-home --shell {shell} --comment \"{fullname}\" {username}")

    ## Create authorized_keys file
    print(f"Create authorized keys file for {username}")
    with open(f'/etc/ssh/authorized_keys/{username}', 'w+') as fh:
        fh.write('\n'.join([f"{key['type']} {key['key']} ## {key['comment']}\n" for key in ssh_keys]))

    ## Set permissions on authorized_keys
    os.system(f"chmod 0600 /etc/ssh/authorized_keys/{username}")
    os.system(f"chown {username}:{username} /etc/ssh/authorized_keys/{username}")

