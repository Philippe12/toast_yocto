#!/bin/bash

source /root/poky/oe-init-build-env /mnt

source toaster start webport="0.0.0.0:8000" toasterdir="/mnt"
while true; do $(echo date); sleep 1; done
