#!/bin/bash

source /home/builderuser/poky/oe-init-build-env /mnt

source toaster start webport="0.0.0.0:8000" toasterdir="/mnt"
/home/builderuser/poky/bitbake/lib/toaster/manage.py makemigrations
/home/builderuser/poky/bitbake/lib/toaster/manage.py migrate
source toaster stop

source toaster start webport="0.0.0.0:8000" toasterdir="/mnt"
while true; do $(echo date); sleep 120; done
