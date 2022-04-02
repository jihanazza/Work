#!/bin/bash

mkdir -p ~/.config/rclone
echo "$rclone_config" > ~/.config/rclone/rclone.conf

cd /cirrus/rom
git config --global user.name "ariffjenong"
git config --global user.email "arifbuditantodablekk@gmail.com"
git config --global color.ui false
